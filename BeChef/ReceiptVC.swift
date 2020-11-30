//
//  ReceiptVC.swift
//  BeChef
//
//  Created by abdulrazak on 04/11/20.
//

import UIKit
import CloudKit

struct receiptmodel {
    var title: String
    var seasoning: String
    var instruction: String
    var ingredient: String
    var images: String
    var description: String
}

class ReceiptVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblfilter: UILabel!
    
    let database = CKContainer.default().publicCloudDatabase
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrayReminder = [CKRecord]()
    var searchArr = [CKRecord]()
    var receiptdetail = [receiptmodel]()
   
    var finalbahan = ""
 
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
      //  searchBar.delegate = self
        
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshcontrol.addTarget(self, action: #selector(querydatabase), for: .valueChanged)
        querydatabase()
       
        self.tblView.refreshControl = refreshcontrol
        
        
        print("ini diluar \(finalbahan)")
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailReceiptVC
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    @objc func querydatabase() {
        let query = CKQuery(recordType: "bechef",predicate: NSPredicate(value: true))
        database.perform(query,inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            self.arrayReminder = records
           // print(self.arrayReminder)
            self.searchArr = self.arrayReminder
          //  self.receiptdetail = self.searchArr as NSString
           // print(self.searchArr)
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }

 
}

extension ReceiptVC: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
    let searchTerms = finalbahan.components(separatedBy: " ").filter{ $0 != "" }
   /* return searchArr.filter({ (record) -> Bool in
       
        return (record.value(forKey: "ingredient") as! String).contains(finalbahan)
       
    }).count */
    
    return searchArr.filter({ (record) -> Bool in
        for term in searchTerms {
            if (record.value(forKey: "ingredient") as! String).lowercased().contains(term.lowercased()) {
                return true
            }
        }
        //(record.value(forKey: "ingredient") as! String).contains(finalbahan)
     return false
    }).count
    
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTVC
        let searchTerms = finalbahan.components(separatedBy: " ").filter{$0 != ""}
        searchArr = arrayReminder.filter({ (record) -> Bool in
            for term in searchTerms {
                if (record.value(forKey: "ingredient") as! String).lowercased().contains(term.lowercased()) {
                    return true
                }
            }
            //(record.value(forKey: "ingredient") as! String).contains(finalbahan)
         return false
        })
       // print(searchArr)
        let item = searchArr[indexPath.row].value(forKey: "title") as! String
        let items = searchArr[indexPath.row].value(forKey: "ingredient") as! String
        let imageasset: CKAsset = searchArr[indexPath.row].value(forKey: "images") as! CKAsset
        cell.img.image = UIImage(contentsOfFile: imageasset.fileURL!.path)
        
        cell.cardView.layer.cornerRadius = 12.0
        
        //print("ini didalam \(finalbahan)")
        cell.lbltitle?.text = item
        cell.lbldeskripsi?.text = items
        
      //    cell?.configure(picture: pictures[indexPath.row], title: titles[indexPath.row], description: descriptions[indexPath.row])
        
               
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       let imageasset: CKAsset = searchArr[indexPath.row].value(forKey: "images") as! CKAsset
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeStepVC") as? RecipeStepVC
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.tittle = searchArr[indexPath.row].value(forKey: "title") as! String
        vc?.bumbu = searchArr[indexPath.row].value(forKey: "seasoning") as! String
        vc?.step = searchArr[indexPath.row].value(forKey: "instruction") as! String
        vc?.image = UIImage(contentsOfFile: imageasset.fileURL!.path)!
        
        
    }
}

/*extension ReceiptVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchArr = arrayReminder.filter({ (record) -> Bool in
            return (record.value(forKey: "title") as! String).contains(searchText)
           
        })
        tblView.reloadData()
    }
   
} */
