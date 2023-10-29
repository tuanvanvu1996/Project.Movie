//
//  ScreenSelectedViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit

class ScreenSelectedViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 6
        registerBtn.layer.cornerRadius = 6
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
        present(gotoLogin, animated: true)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
    }
    
}
