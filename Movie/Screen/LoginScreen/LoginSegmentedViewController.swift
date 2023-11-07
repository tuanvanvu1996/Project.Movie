//
//  LoginSegmentedViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit

class LoginSegmentedViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var loginSegmented: UISegmentedControl!
    @IBOutlet weak var loginEmailSegmented: UIView!
    @IBOutlet weak var loginPhoneSegmented: UIView!
    
    @IBOutlet weak var descriptionLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        backBtn.layer.cornerRadius = 6
        backBtn.layer.borderWidth = 1
        
    }
    
    @IBAction func loginSegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(loginEmailSegmented)
            descriptionLb.text = "Welcome back! Glad to see you, Again!"
        case 1:
            self.view.bringSubviewToFront(loginPhoneSegmented)
            descriptionLb.text = "Please enter your phone number!"
        default:
            break
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let gotoSelected = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ScreenSelectedViewController")
        navigationController?.pushViewController(gotoSelected, animated: true)
    }
    
}
