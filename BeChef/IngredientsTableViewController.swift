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
    
    // Array isinya tag             0     1      2          3
    var ingredientsNameCollection = ["", "Apple", "Cheese", "Chicken", "Chili", "Egg", "Lettuce", "Mushroom", "Noodle", "Onion"]
    var buttonTagsCollection: [Int] = []
    
    // variable untuk menampung hasil pilihan igredients
    var selectedIngredients = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
}
