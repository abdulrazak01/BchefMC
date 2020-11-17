//
//  OnboardingViewController.swift
//  BeChef
//
//  Created by Rian Anjasmara on 14/11/20.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    
    @IBOutlet weak var imgBG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
//        view.backgroundColor = .systemBackground
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            imgBG.image = UIImage (named: "BgScreenDark")
        case .light:
            imgBG.image = UIImage (named: "BgScreen")
        default:
            print("Default")
        }

        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
