//
//  ProfileViewController.swift
//  Movie
//
//  Created by AsherFelix on 11/1/23.
//

import UIKit
import FirebaseAuth
class ProfileViewController: UIViewController {
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutBtn.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
    }
    

 
    @IBAction func logoutBtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("Log out success")
            let gotoLoginNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
            navigationController?.pushViewController(gotoLoginNav, animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}
