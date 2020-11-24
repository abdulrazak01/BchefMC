//
//  IngredientsTableViewController.swift
//  BeChef
//
//  Created by Agus Riady on 03/11/20.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    weak var delegate: IngredientsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
    }
    

}
