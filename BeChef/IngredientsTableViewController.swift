//
//  IngredientsTableViewController.swift
//  BeChef
//
//  Created by Agus Riady on 03/11/20.
//

import UIKit

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
    var ingredientsNameCollection = ["", "Apple", "Cheese", "Chicken", "Chili", "Egg", "Lettuce", "Mushroom", "Noodle", "Onion"]
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
            sender.backgroundColor = .yellow
        } else {
            buttonTagsCollection.append(sender.tag)
            sender.backgroundColor = .orange
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
