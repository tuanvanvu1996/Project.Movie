//
//  CongratulationsViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit

class CongratulationsViewController: UIViewController {
   
    @IBOutlet weak var signInHereBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInHereBtn.layer.cornerRadius = 6
    }
    
    @IBAction func signInHere(_ sender: Any) {
        let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
        navigationController?.pushViewController(gotoLogin, animated: true)
    }
    

}
