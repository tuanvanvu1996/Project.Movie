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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginSegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(loginEmailSegmented)
        case 1:
            self.view.bringSubviewToFront(loginPhoneSegmented)
        default:
            break
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
    }
    
}
