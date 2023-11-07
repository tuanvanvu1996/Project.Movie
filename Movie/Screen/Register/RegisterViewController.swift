//
//  RegisterViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit
import MBProgressHUD
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
class RegisterViewController: UIViewController {
    var passwordCheck:Bool = false
    var confirmPasswordCheck:Bool = false
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorEmail: UIView!
    @IBOutlet weak var errorEmailLB: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorPassword: UIView!
    @IBOutlet weak var passwordShow: UIButton!
    @IBOutlet weak var errorPasswordLb: UILabel!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var errorConfirmPassword: UIView!
    @IBOutlet weak var errorConfirmPasswordLb: UILabel!
    @IBOutlet weak var confirmPasswordShow: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationController?.isNavigationBarHidden = true
        setupEmailSuccess()
        setupPasswordSuccess()
        setupConfirmPasswordSuccess()
    }
    private func setupView() {
        backBtn.layer.cornerRadius = 6
        backBtn.layer.borderWidth = 1
        emailTF.placeholder = "Email Address"
        passwordTF.placeholder = "Password"
        confirmPasswordTF.placeholder = "ConfirmPassword"
        emailTF.clearButtonMode = .whileEditing
        emailTF.layer.cornerRadius = 6
        passwordTF.layer.cornerRadius = 6
        emailTF.layer.borderWidth = 1
        passwordTF.layer.borderWidth = 1
        confirmPasswordTF.layer.borderWidth = 1
        confirmPasswordTF.layer.cornerRadius = 6
        backBtn.layer.cornerRadius = 6
        registerBtn.layer.cornerRadius = 6
    }
    
    private func setupEmailSuccess() {
        errorEmail.isHidden = true
        emailTF.keyboardType = .emailAddress
        emailTF.layer.borderColor = UIColor.black.cgColor
        emailTF.backgroundColor = .clear
        
    }
    private func setupPasswordSuccess() {
        errorPassword.isHidden = true
        passwordTF.isSecureTextEntry = true
        passwordTF.layer.borderColor = UIColor.black.cgColor
        passwordTF.backgroundColor = .clear
        
    }
    private func setupConfirmPasswordSuccess() {
        errorConfirmPassword.isHidden = true
        confirmPasswordTF.isSecureTextEntry = true
        confirmPasswordTF.layer.borderColor = UIColor.black.cgColor
        confirmPasswordTF.backgroundColor = .clear
    }
    
    private func setupEmailFail() {
        errorEmail.isHidden = false
        emailTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        emailTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
        
    }
    private func setupPasswordFail() {
        errorPassword.isHidden = false
        passwordTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        passwordTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    private func setupConfirmPasswordFail() {
        errorConfirmPassword.isHidden = false
        confirmPasswordTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        confirmPasswordTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    @IBAction func registerBtn(_ sender: Any) {
        let emailText = emailTF.text ?? ""
        var emailSuccess = false
        if emailText.isEmpty {
            errorEmailLB.text = "Email can't Empty"
            setupEmailFail()
        }else if emailText.count < 6 || emailText.count > 40 {
            errorEmailLB.text = "Email must been 6 and 40 character"
            setupEmailFail()
        }else if !(isValidEmail(emailText)) {
            errorEmailLB.text = "Invalid Email"
            setupEmailFail()
        }else {
            setupEmailSuccess()
            emailSuccess = true
        }
        let passwordText = passwordTF.text ?? ""
        var passwordSuccess: Bool = false
        if passwordText.isEmpty {
            errorPasswordLb.text = "Password can't Empty"
            setupPasswordFail()
        }else if passwordText.count < 6 || passwordText.count > 40 {
            errorPasswordLb.text = "Password must been 6 and 40 character"
            setupPasswordFail()
        }else if !(isValidPassword(passwordText)) {
            errorPasswordLb.text = "Invalid Password"
            setupPasswordFail()
        }else if !passwordText.contains(where: {$0.isUppercase}) {
            errorPasswordLb.text = "Password need one Uppercase"
            setupPasswordFail()
        }else {
            setupPasswordSuccess()
            passwordSuccess = true
        }
        let confirmPasswordText = confirmPasswordTF.text ?? ""
        var confirmPasswordSuccess = false
        if confirmPasswordText.isEmpty {
            errorConfirmPasswordLb.text = "Confirm Password can't Empty"
            setupConfirmPasswordFail()
        }else if confirmPasswordText != passwordText {
            errorConfirmPasswordLb.text = "Not the same as the password above"
            setupConfirmPasswordFail()
        }else {
            setupConfirmPasswordSuccess()
            confirmPasswordSuccess = true
        }
        
        let isValidRegister = emailSuccess && passwordSuccess && confirmPasswordSuccess
        
        if isValidRegister == true {
            registerFirebase()
        }
    }
    private func registerFirebase() {
        showLoading(isShow: true)
        guard  let email = emailTF.text, let password = passwordTF.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard error == nil else {
                var messenger = ""
                switch AuthErrorCode.Code(rawValue: error!._code) {
                case .emailAlreadyInUse :
                    messenger = "Email already exists"
                case .invalidEmail :
                    messenger = "Email is Invalid"
                default :
                    messenger = error?.localizedDescription ?? ""
                }
                self.showLoading(isShow: false)
                self.showAlert(title: "Note", messenger: messenger)
                return
            }
            self.showAlertRegister(title: "Note", messenger: "Register Success")
        }
    }
    func showAlertRegister(title:String,messenger: String) {
        let alert = UIAlertController(title: title, message: messenger, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
            self.navigationController?.pushViewController(gotoLogin, animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    @IBAction func signInBtn(_ sender: Any) {
        let backToLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
        navigationController?.pushViewController(backToLogin, animated: true)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        passwordCheck.toggle()
        if passwordCheck {
            passwordShow.setImage(UIImage(named: "show"), for: .normal)
            passwordTF.isSecureTextEntry = false
        }else {
            passwordShow.setImage(UIImage(named: "hidden"), for: .normal)
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func confirmPasswordShow(_ sender: Any) {
        confirmPasswordCheck.toggle()
        if confirmPasswordCheck {
            confirmPasswordShow.setImage(UIImage(named: "show"), for: .normal)
            confirmPasswordTF.isSecureTextEntry = false
        }else {
            confirmPasswordShow.setImage(UIImage(named: "hidden"), for: .normal)
            confirmPasswordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        let backToLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
        navigationController?.pushViewController(backToLogin, animated: true)
    }
}
