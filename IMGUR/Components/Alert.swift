//
//  Alert.swift
//  IMGUR
//
//  Created by Lucas Bordini on 01/09/20.
//  Copyright © 2020 Lucas Bordini. All rights reserved.
//

import UIKit

class Alert {
    
    static func createAlert(title: String?, message: String, button: String, otherButtons: [(String, (() -> Void)?)], action: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: button, style: .cancel) { _ in action?() }
        alert.addAction(buttonAction)
        if !otherButtons.isEmpty {
            for button in otherButtons {
                let otherAction = UIAlertAction(title: button.0, style: .default) { _ in button.1?() }
                alert.addAction(otherAction)
            }
        }
        return alert
    }
    
    static func createErrorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error !", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        return alert
    }
}
