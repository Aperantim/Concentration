//
//  ConcentrationThemeChooserViewController.swift
//  SuperConcentration
//
//  Created by Виталий on 06.11.2019.
//  Copyright © 2019 Aperantim. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [
        "Sports":"⚽️🏀🏈🎾🏸🏓🏒🏐",
        "Animals":"🐸🐷🙈🐙🦖🐄🐓🐊",
        "Faces":"🤮🥺🤗😘🥶🥱😛😭",
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                    }
                }
            }
        }
    }
    
}
