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

    @IBOutlet weak var lblbumbu: UILabel!
    @IBOutlet weak var lblstep: UILabel!
    
    @IBOutlet weak var lblTitleSea: UILabel!
    @IBOutlet weak var lblTitleStep: UILabel!
    
    
    var image = UIImage()
    var tittle = ""
    var bumbu = ""
    var step = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        lblTitleSea.text = "Seasoning"
        lblTitleStep.text = "Instruction"
        
        lbltitle.text = tittle
        lblbumbu.text = bumbu
        lblstep.text = step
        detailimg.image = image
        
      //  lblbumbu.isEditable = false
       // lblstep.isEditable = false
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
