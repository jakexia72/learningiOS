//
//  ThemeChooserViewController.swift
//  concentration
//
//  Created by Jake Xia on 2019-02-05.
//  Copyright © 2019 Jake Xia. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    let themes = [
        "animals": "asdfghj"
    ]
    // MARK: - Navigation

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName]{
                    if let cvc = segue.destination as? concentrationViewController
            }
        }
    }
 

}
