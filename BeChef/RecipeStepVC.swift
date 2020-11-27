//
//  ScrollStepVC.swift
//  BeChef
//
//  Created by Rian Anjasmara on 23/11/20.
//

import UIKit

class RecipeStepVC: UIViewController {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var detailimg: UIImageView!
    @IBOutlet weak var lblTitleSea: UILabel!
    @IBOutlet weak var lblbumbu: UILabel!
    @IBOutlet weak var lblTitleStep: UILabel!
    @IBOutlet weak var lblstep: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    
    
    
    var image = UIImage()
    var tittle = ""
    var bumbu = ""
    var step = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func didTapBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailReceiptVC
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.step = step
        
    }
    
}
