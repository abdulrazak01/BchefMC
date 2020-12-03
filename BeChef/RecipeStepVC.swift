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
    
    @IBOutlet weak var lbltime: UILabel!
    
    
    var dataJson = [Jobs]()
    var image = UIImage()
    var tittle = ""
    var bumbu = ""
    var step = ""
    var stepToText = [String]()
    var time = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tampilLabel()
        lblTitleSea.text = "Bahan Tambahan:"
        lblTitleStep.text = "Langkah:"
        
        lbltitle.text = tittle
        lblbumbu.text = bumbu
        lblstep.text = stepToText.joined(separator: " \n")
        detailimg.image = image
        lbltime.text = "􀐯 Durasi \(time)"
        
        lbltitle.font = UIFont(name: "SFProRounded-Bold", size: 32)
        lblTitleSea.font = UIFont(name: "SFProRounded-Bold", size: 20)
        lblTitleStep.font = UIFont(name: "SFProRounded-Bold", size: 20)
        
        lbltime.font = UIFont(name: "SFProRounded-Regular", size: 17)
        lblbumbu.font = UIFont(name: "SFProRounded-Regular", size: 17)
        lblstep.font = UIFont(name: "SFProRounded-Regular", size: 17)
        lbltime.font = UIFont(name: "SFProRounded-Regular", size: 17)
        lbltime.textColor = UIColor(hexString: "B5A3A3")
        
        
        detailBtn.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 24)
        detailBtn.backgroundColor = UIColor(hexString: "FF6B00")
        detailBtn.setTitle("Mode per Langkah", for: .normal)
    
        detailBtn.layer.cornerRadius = 6
        
        
        
    }
    
    
    func tampilLabel(){
        print("= STEP ===================")
        print(step)
        print("==========================")
        let JsonfromCK = step.self
        let JsonString = JsonfromCK.data(using: .utf8)!
        let decoder = JSONDecoder()
        let Json = try! decoder.decode(langkah.self, from: JsonString)
        self.dataJson = Json.jobs
        
        for i in 0..<dataJson.count {
            let noStep = dataJson[i].step!
            let instruksi = dataJson[i].instruksi!
            let joinText = "\(noStep). " + instruksi
            stepToText.append(joinText)
            
        }
    }
    
    @IBAction func didTapBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailReceiptVC
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.step1 = step
        vc?.tittle1 = tittle
        vc?.bumbu1 = bumbu
        vc?.image1 = image
        
    }
    
}
