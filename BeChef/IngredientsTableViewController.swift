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
    
    @IBOutlet weak var apple: UIButton!
    @IBOutlet weak var cheese: UIButton!
    @IBOutlet weak var chicken: UIButton!
    @IBOutlet weak var chili: UIButton!
    @IBOutlet weak var egg: UIButton!
    @IBOutlet weak var lettuce: UIButton!
    @IBOutlet weak var mushroom: UIButton!
    @IBOutlet weak var noodle: UIButton!
    @IBOutlet weak var onion: UIButton!
    
    
    // Array isinya tag             0     1      2          3
    var ingredientsNameCollection = ["", "Telur", "Terong", "Tahu", "Tauge", "Tempe", "Lettuce", "Mushroom", "Noodle", "Onion"]
    var buttonTagsCollection: [Int] = []
    
    // variable untuk menampung hasil pilihan igredients
    var selectedIngredients = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        apple.layer.cornerRadius = 10.0
        cheese.layer.cornerRadius = 10.0
        chicken.layer.cornerRadius = 10.0
        chili.layer.cornerRadius = 10.0
        egg.layer.cornerRadius = 10.0
        lettuce.layer.cornerRadius = 10.0
        mushroom.layer.cornerRadius = 10.0
        noodle.layer.cornerRadius = 10.0
        onion.layer.cornerRadius = 10.0
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
