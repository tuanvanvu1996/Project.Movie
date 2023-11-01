//
//  ForgetPasswordViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit
import FirebaseAuth
class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var resetPasswordTF: UIButton!
    @IBOutlet weak var errorEmail: UIView!
    @IBOutlet weak var errorEmailLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 6
        emailTF.layer.cornerRadius = 6
        emailTF.layer.borderWidth = 1
        resetPasswordTF.layer.cornerRadius = 6
        setupEmailSuccess()
        
    }
    private func setupEmailSuccess() {
        errorEmail.isHidden = true
        emailTF.keyboardType = .emailAddress
        emailTF.backgroundColor = .white
        emailTF.layer.borderColor = UIColor.black.cgColor
        
    }
    private func setupEmailFail() {
        errorEmail.isHidden = false
        emailTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        emailTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passwordReset(_ sender: Any) {
        let emailText = emailTF.text ?? ""
        var emailSuccess = false
        if emailText.isEmpty {
            errorEmailLb.text = "Email can't Empty"
            setupEmailFail()
        }else if emailText.count < 6 || emailText.count > 40 {
            errorEmailLb.text = "Email must been 6 and 40 character"
            setupEmailFail()
        }else if !(isValidEmail(emailText)) {
            errorEmailLb.text = "Invalid Email"
            setupEmailFail()
        }else {
            setupEmailSuccess()
            emailSuccess = true
        }
        let isValidEmail = emailSuccess
        if isValidEmail == true {
            showLoading(isShow: true)
            guard  let email = emailTF.text else {
                return
            }
            var messenger = ""
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if let error = error {
                    switch AuthErrorCode.Code(rawValue: error._code) {
                    case .invalidEmail:
                        messenger = "Invalid Email"
                    case .appNotVerified :
                        messenger = "App not Verified"
                    default:
                        break
                    }
                    self.showAlert(title: "Note", messenger: messenger)
                    self.showLoading(isShow: false)
                    return
                }
            }
            let resetSuccess = UIAlertController(title: "Note", message: "Please check your Email", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
                let gotoCongratulation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CongratulationsViewController")
                self.navigationController?.pushViewController(gotoCongratulation, animated: true)
            }
            resetSuccess.addAction(action)
            present(resetSuccess, animated: true)
        }
        
    }
    
}
