//
//  LoginEmailViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
class LoginEmailViewController: UIViewController {
    var rememberTogle:Bool = false
    var passwordTogle:Bool = false
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorEmail: UIView!
    @IBOutlet weak var errorEmailLb: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorPassword: UIView!
    @IBOutlet weak var errorPasswordLb: UILabel!
    @IBOutlet weak var googleLogin: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var checkRemember: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupView()
        setupEmailSuccess()
        setupPasswordSuccess()
       
    }
    private func setupView() {
        emailTF.placeholder = "Enter your Email"
        passwordTF.placeholder = " Enter your Password"
        emailTF.layer.cornerRadius = 6
        emailTF.layer.borderWidth = 1
        passwordTF.layer.cornerRadius = 6
        passwordTF.layer.borderWidth = 1
        emailTF.clearButtonMode = .whileEditing
        googleLogin.layer.cornerRadius = 6
        facebookLogin.layer.cornerRadius = 6
        passwordTF.isSecureTextEntry = true
        loginBtn.layer.cornerRadius = 6
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
    private func setupPasswordSuccess() {
        errorPassword.isHidden = true
        passwordTF.backgroundColor = .white
        passwordTF.layer.borderColor = UIColor.black.cgColor
        showPassword.setImage(UIImage(named: "hidden"), for: .normal)
    }
    private func setupPasswordFail() {
        errorPassword.isHidden = false
        passwordTF.layer.borderColor = UIColor(red: 0.76, green: 0.00, blue: 0.32, alpha: 1.00).cgColor
        passwordTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    @IBAction func forgetPassword(_ sender: Any) {
        let gotoForget = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ForgetPasswordViewController")
        navigationController?.pushViewController(gotoForget, animated: true)
    }
    
    @IBAction func rememberLogin(_ sender: Any) {
        rememberTogle.toggle()
        if rememberTogle {
            checkRemember.setImage(UIImage(named: "check"), for: .normal)
        } else {
            checkRemember.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    
    @IBAction func passwordShow(_ sender: Any) {
        passwordTogle.toggle()
        if passwordTogle {
            showPassword.setImage(UIImage(named: "show"), for: .normal)
            passwordTF.isSecureTextEntry = false
        }else {
            showPassword.setImage(UIImage(named: "hidden"), for: .normal)
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        let emailText = emailTF.text ?? ""
        var emailSuccess: Bool = false
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
        
        let passwordText = passwordTF.text ?? ""
        var passwordSuccess: Bool = false
        if passwordText.isEmpty {
            errorPasswordLb.text = "Password can't Empty"
            setupPasswordFail()
        }else if passwordText.count < 6 || passwordText.count > 40 {
            errorPasswordLb.text = "Password must been 6 and 40 character"
            setupPasswordFail()
        }else {
            setupPasswordSuccess()
            passwordSuccess = true
        }
        
        let isValidLogin = emailSuccess && passwordSuccess
        if isValidLogin == true {
            loginWithFirebase()
            if rememberTogle == true {
                UserDefaults.standard.set("1", forKey: "rememberMe")
                UserDefaults.standard.set(emailTF.text ?? "", forKey: "rememberEmail")
                UserDefaults.standard.set(passwordTF.text ?? "", forKey: "rememberPassword")
                print("Remember Email and Password")
            }else {
                UserDefaults.standard.set("2", forKey: "rememberMe")
            }
        }
        
    }
    private func loginWithFirebase() {
        showLoading(isShow: true)
        guard  let email = emailTF.text, let password = passwordTF.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let _ = error {
                self.showAlert(title: "Note", messenger: "Wrong Email or Password")
                self.showLoading(isShow: false)
            }else {
                let alertLoginSuccess = UIAlertController(title: "Note", message: "Login Success", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
                    let gotoMain = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
                    self.navigationController?.pushViewController(gotoMain, animated: true)
                }
                alertLoginSuccess.addAction(alertAction)
                self.present(alertLoginSuccess, animated: true)
            }
        }
    }
    private func checkRememberLogin() {
        if UserDefaults.standard.string(forKey: "rememberMe") == "1" {
            checkRemember.setImage(UIImage(named: "check"), for: .normal)
            rememberTogle = true
            self.emailTF.text = UserDefaults.standard.string(forKey: "rememberEmail") ?? ""
            self.passwordTF.text = UserDefaults.standard.string(forKey: "rememberPassword") ?? ""
        }else {
            checkRemember.setImage(UIImage(named: "uncheck"), for: .normal)
            rememberTogle = false
        }
    }
    @IBAction func googleLogin(_ sender: Any) {
        showLoading(isShow: true)
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
                return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    var messenger = ""
                    switch AuthErrorCode.Code(rawValue: error!._code) {
                    case .emailAlreadyInUse :
                        messenger = "Email already exists"
                    case .invalidEmail :
                        messenger = "Invalid Email"
                    default :
                        messenger = error?.localizedDescription ?? ""
                    }
                    self.showLoading(isShow: false)
                    self.showAlert(title: "Note", messenger: messenger)
                    return
                }
                self.showAlertLoginSuccess(title: "Note", messenger: "Login Success")
            }
        }
    }
    func showAlertLoginSuccess  (title:String,messenger: String) {
        let alert = UIAlertController(title: title, message: messenger, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
            self.navigationController?.pushViewController(gotoLogin, animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    @IBAction func facebookLogin(_ sender: Any) {
        
        
    }
    
    @IBAction func creatAccount(_ sender: Any) {
        let gotoCreatAccountNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController")
        navigationController?.pushViewController(gotoCreatAccountNav, animated: true)
        
    }
}
