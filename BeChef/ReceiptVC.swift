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
        configureNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailReceiptVC
    }

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
    
    // MARK: - Added by Bayu
    
    private func configureNavigationBar() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBarButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func searchBarButtonPressed() {
        print("This is the fetched records")
        convertFetchedRecordToDictionary { results in
            switch results {
            case .success(let foods):
                print(foods)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func convertFetchedRecordToDictionary(_ completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "bechef", predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
               return
            }
            
            guard let record = records else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "com.AgusRiady.BeChef", code: 001, userInfo: [NSLocalizedDescriptionKey: "Failed fetching data"])
                    completion(.failure(error))
                }
                return
            }
            
            let foods = record.map { $0.asDictionary() } as! [Dictionary<String, Any>]
            completion(.success(foods))
          
        }
    }
}

extension ReceiptVC: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 260
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
        cell.img.layer.cornerRadius = 10
        //print("ini didalam \(finalbahan)")
        cell.lbltitle?.text = item
        cell.lbldeskripsi?.text = items
        
      //    cell?.configure(picture: pictures[indexPath.row], title: titles[indexPath.row], description: descriptions[indexPath.row])
        
               
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
        let imageasset: CKAsset = searchArr[indexPath.row].value(forKey: "images") as! CKAsset
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailReceiptVC
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

extension CKRecord {
    func asDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        for key in self.allKeys() {
            if let value = self.object(forKey: key) {
                var path: [String] = key.components(separatedBy: "__")
                if path.count == 1 {
                    dictionary.setObject(value, forKey: key as NSCopying)
                } else {
                    var tempDict = dictionary
                    var tempKey = key
                    let lastKey = path[path.count - 1]
                    path.removeLast()
                    for item in path {
                        tempKey = item
                        if tempDict[tempKey] == nil {
                            tempDict.setObject(NSMutableDictionary(), forKey: tempKey as NSCopying)
                        }
                        tempDict = (tempDict[tempKey] as? NSMutableDictionary) ?? NSMutableDictionary()
                    }
                    tempDict.setObject(value, forKey: lastKey as NSCopying)
                }
            }
        }
        return dictionary
    }
}
