//
//  ViewController.swift
//  BeChef
//
//  Created by Agus Riady on 02/11/20.
//

import UIKit

protocol IngredientsDelegate: class {
    func finishSelectIngredients(selectedIngredients: [String])
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

let ingredientsYellow = UIColor(hexString: "#FED439")


class ViewController: UIViewController {

    //var selectedIngredients = [String]()
    var checked = false
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    
   
    
    
    @IBOutlet weak var nasi: UIButton!
    @IBOutlet weak var mie: UIButton!
    @IBOutlet weak var telur: UIButton!
    @IBOutlet weak var roti: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nasi.layer.cornerRadius = 10.0
        mie.layer.cornerRadius = 10.0
        telur.layer.cornerRadius = 10.0
        roti.layer.cornerRadius = 10.0
        
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        lblSubTitle.textAlignment = .center
        lblSubTitle.font = UIFont(name: "SFProRounded-Regular", size: 24)
        
        searchButton.isEnabled = false
        searchButton.backgroundColor = .gray
        searchButton.layer.cornerRadius = 10.0
        searchButton.setTitle("Ayo Masak!", for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 32)
        
        label()
      
        
    }
    
    func label(){
        //title Label
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 60, width: view.frame.size.width-40, height: 120))
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "SFProRounded-Bold", size: 38)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.text = "Mulai Memasak"
        view.addSubview(titleLabel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueGoTo" {
            var vc1 = segue.destination as! ReceiptVC
            vc1.finalbahan = ingredientsLabel.text!
        }
        //performSegue(withIdentifier: "segueGoTo", sender: self)
    }
    
    @IBAction func nasi(_ sender: UIButton) {
        if checked {
            sender.setImage(UIImage(named: "NasiGG"), for: .normal)
                
            } else {
                sender.setImage(UIImage(named: "Nasi Selected"), for: .normal)
                
            }
    }
    @IBAction func mie(_ sender: UIButton) {
        if checked {
            sender.setImage(UIImage(named: "Mie Idle"), for: .normal)
                
            } else {
                sender.setImage(UIImage(named: "Mie Selected"), for: .normal)
                
            }
    }
    
    @IBAction func telur(_ sender: UIButton) {
        if checked {
            sender.setImage(UIImage(named: "Telurgg"), for: .normal)
                
            } else {
                sender.setImage(UIImage(named: "Telur Selected"), for: .normal)
                
            }
        
    }
    
    @IBAction func roti(_ sender: UIButton) {
        if checked {
            sender.setImage(UIImage(named: "Roti Idle"), for: .normal)
                
            } else {
                sender.setImage(UIImage(named: "Roti Selected"), for: .normal)
                
            }
    }
    
    // Array isinya tag             0     1      2          3
    var ingredientsNameCollection = ["", "nasi", "mie", "telur", "roti"]
    var buttonTagsCollection: [Int] = []
    
    // variable untuk menampung hasil pilihan igredients
    var selectedIngredients = [String]()
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if let foundIndex = buttonTagsCollection.lastIndex(of: sender.tag) {
            buttonTagsCollection.remove(at: foundIndex)
           checked = true
        } else {
            buttonTagsCollection.append(sender.tag)
           checked = false
        }
        
        selectedIngredients = []
        
        // refresh smua data selected ingredients
        for i in buttonTagsCollection {
            selectedIngredients.append(ingredientsNameCollection[i])
        }
        
        print(selectedIngredients)
        
        ingredientsLabel.text = selectedIngredients.joined(separator: " ")
    
        if self.selectedIngredients.count > 0 {
        // Enable button
            searchButton.isEnabled = true
            searchButton.backgroundColor = .orange
            
            
        } else {
            searchButton.isEnabled = false
            searchButton.backgroundColor = .gray
        }
    }
    
    

}



