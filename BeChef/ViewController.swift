//
//  ViewController.swift
//  BeChef
//
//  Created by Agus Riady on 02/11/20.
//

import UIKit

class ViewController: UIViewController, IngredientsDelegate {

    var selectedIngredients = [String]()
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchButton.isEnabled = false
        searchButton.backgroundColor = .gray
        searchButton.layer.cornerRadius = 10.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueGoToIngredients" {
            if let nc = segue.destination as? UINavigationController {
                if let vc = nc.viewControllers[0] as? IngredientsTableViewController {
                    // Step 4
                    vc.delegate = self
                }
            }
        }
    }
    
    // Step 6
    // conform to IngredientsDelegate
    func finishSelectIngredients(selectedIngredients: [String]) {
        ingredientsLabel.text = selectedIngredients.joined(separator: ", ")
    
        self.selectedIngredients = selectedIngredients
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

