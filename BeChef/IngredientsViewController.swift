//
//  ViewController.swift
//  BeChef
//
//  Created by Agus Riady on 02/11/20.
//

import UIKit

class IngredientsViewController: UIViewController {


    @IBOutlet weak var kotakapple: UIImageView!
    @IBOutlet weak var apple: UIButton!
    
    var ingredients = [UIColor.systemYellow, UIColor.systemOrange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func apple(_ sender: Any) {
        ingredients.shuffle()
    }
}

