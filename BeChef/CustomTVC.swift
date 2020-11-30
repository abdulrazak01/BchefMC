//
//  CustomTVC.swift
//  BeChef
//
//  Created by abdulrazak on 04/11/20.
//

import UIKit

class CustomTVC: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbldeskripsi: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = 12.0
        
       
       lbltitle.font = UIFont(name: "SFProRounded-Bold", size: 20)
        lbldeskripsi.font = UIFont(name: "SFProRounded- Regular", size: 17)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
