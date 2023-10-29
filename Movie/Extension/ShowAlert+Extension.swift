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
}
