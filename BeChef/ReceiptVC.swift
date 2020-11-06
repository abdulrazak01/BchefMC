//
//  ReceiptVC.swift
//  BeChef
//
//  Created by abdulrazak on 04/11/20.
//

import UIKit
import CloudKit
class ReceiptVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    
    let database = CKContainer.default().publicCloudDatabase
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrayReminder = [CKRecord]()
    var searchArr = [CKRecord]()
    
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshcontrol.addTarget(self, action: #selector(querydatabase), for: .valueChanged)
        querydatabase()
        self.searchBar.delegate = self
        self.tblView.refreshControl = refreshcontrol
        
       
        // Do any additional setup after loading the view.
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
            print(self.searchArr)
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }


}

extension ReceiptVC: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 260
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return searchArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTVC
        let item = searchArr[indexPath.row].value(forKey: "title") as! String
        let items = searchArr[indexPath.row].value(forKey: "description") as! String
        
        cell.lbltitle?.text = item
        cell.lbldeskripsi?.text = items
        
      //    cell?.configure(picture: pictures[indexPath.row], title: titles[indexPath.row], description: descriptions[indexPath.row])
        
               
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 /*       let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.image = pictures[indexPath.row]
        vc?.tittle = titles[indexPath.row]
        vc?.deskripsion = deskripsi[indexPath.row] */
    }
}

extension ReceiptVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchArr = arrayReminder.filter({ (record) -> Bool in
            return (record.value(forKey: "title") as! String).contains(searchText)
            
        })
        tblView.reloadData()
    }
}
