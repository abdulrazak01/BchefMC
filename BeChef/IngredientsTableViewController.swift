//
//  IngredientsTableViewController.swift
//  BeChef
//
//  Created by Agus Riady on 03/11/20.
//

import UIKit

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

protocol IngredientsDelegate: class {
    func finishSelectIngredients(selectedIngredients: [String])
    
}

class IngredientsTableViewController: UITableViewController {
    weak var delegate: IngredientsDelegate?
    
    @IBOutlet weak var ayam: UIButton!
    @IBOutlet weak var daging: UIButton!
    @IBOutlet weak var ikan: UIButton!
    @IBOutlet weak var jamur: UIButton!
    @IBOutlet weak var kentang: UIButton!
    @IBOutlet weak var mie: UIButton!
    @IBOutlet weak var nasi: UIButton!
    @IBOutlet weak var sosis: UIButton!
    @IBOutlet weak var tahu: UIButton!
    @IBOutlet weak var tauge: UIButton!
    @IBOutlet weak var telur: UIButton!
    @IBOutlet weak var terong: UIButton!
    @IBOutlet weak var tomat: UIButton!
    @IBOutlet weak var udang: UIButton!
    @IBOutlet weak var wortel: UIButton!
    @IBOutlet weak var tag16: UIButton!
    @IBOutlet weak var tag17: UIButton!
    @IBOutlet weak var tag18: UIButton!
    @IBOutlet weak var tag19: UIButton!
    @IBOutlet weak var tag20: UIButton!
    @IBOutlet weak var tag21: UIButton!
    
    
    
    // Array isinya tag             0     1      2          3
    var ingredientsNameCollection = ["", "Ayam", "Daging", "Ikan", "Jamur", "Kacang Panjang" ,"Kangkung", "Kentang", "Kol", "Mie", "Nasi", "Pete" ,"Sosis", "Tahu", "Tauge", "Telur", "Tempe", "Terong", "Timun", "Tomat", "Udang", "Wortel"]
    var buttonTagsCollection: [Int] = []
    
    // variable untuk menampung hasil pilihan igredients
    var selectedIngredients = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ayam.layer.cornerRadius = 10.0
        daging.layer.cornerRadius = 10.0
        ikan.layer.cornerRadius = 10.0
        jamur.layer.cornerRadius = 10.0
        kentang.layer.cornerRadius = 10.0
        mie.layer.cornerRadius = 10.0
        nasi.layer.cornerRadius = 10.0
        sosis.layer.cornerRadius = 10.0
        tahu.layer.cornerRadius = 10.0
        tauge.layer.cornerRadius = 10.0
        telur.layer.cornerRadius = 10.0
        terong.layer.cornerRadius = 10.0
        tomat.layer.cornerRadius = 10.0
        udang.layer.cornerRadius = 10.0
        wortel.layer.cornerRadius = 10.0
        tag16.layer.cornerRadius = 10.0
        tag17.layer.cornerRadius = 10.0
        tag18.layer.cornerRadius = 10.0
        tag19.layer.cornerRadius = 10.0
        tag20.layer.cornerRadius = 10.0
        tag21.layer.cornerRadius = 10.0
   
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if let foundIndex = buttonTagsCollection.lastIndex(of: sender.tag) {
            buttonTagsCollection.remove(at: foundIndex)
            sender.backgroundColor = .white
        } else {
            buttonTagsCollection.append(sender.tag)
            sender.backgroundColor = ingredientsYellow
        }
        
        selectedIngredients = []
        
        // refresh smua data selected ingredients
        for i in buttonTagsCollection {
            selectedIngredients.append(ingredientsNameCollection[i])
        }
        
        print(selectedIngredients)
        
        // Step 3
        // call the delegate funtion
        delegate?.finishSelectIngredients(selectedIngredients: selectedIngredients)
    }
    
    @IBAction func doneButtonTap(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
