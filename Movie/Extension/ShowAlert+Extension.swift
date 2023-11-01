//
//  ShowAlert+Extension.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
    func showLoading(isShow:Bool) {
        if isShow {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    func showAlert(title:String,messenger: String) {
        let alert = UIAlertController(title: title, message: messenger, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}
