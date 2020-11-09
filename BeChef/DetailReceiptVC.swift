//
//  DetailReceiptVC.swift
//  BeChef
//
//  Created by abdulrazak on 07/11/20.
//

import UIKit

class DetailReceiptVC: UIViewController {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var detailimg: UIImageView!
    @IBOutlet weak var lblbumbu: UITextView!
    @IBOutlet weak var lblstep: UITextView!
    
    
    var image = UIImage()
    var tittle = ""
    var bumbu = ""
    var step = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lbltitle.text = tittle
        lblbumbu.text = bumbu
        lblstep.text = step
        detailimg.image = image
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

}
