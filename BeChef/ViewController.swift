//
//  ViewController.swift
//  BeChef
//
//  Created by Agus Riady on 02/11/20.
//

import UIKit

class ViewController: UIViewController, IngredientsDelegate {

    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }
}

