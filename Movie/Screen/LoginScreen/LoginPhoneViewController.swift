//
//  LoginPhoneViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class LoginPhoneViewController: UIViewController {
    var rememberTogle:Bool = false
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var rememberLogin: UIButton!
    @IBOutlet weak var getOTPBtn: UIButton!
    @IBOutlet weak var errorPhone: UIView!
    @IBOutlet weak var errorPhoneLb: UILabel!
    let bottomLinePhone = CALayer()
    let bottomLineNumber = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTF.delegate = self
        phoneTF.borderStyle = .none
        bottomLinePhone.frame = CGRect(x: 0, y: phoneTF.frame.size.height - 1, width: phoneTF.frame.size.width, height: 1)
        bottomLinePhone.backgroundColor = UIColor(red: 0.31, green: 0.29, blue: 0.40, alpha: 1.00).cgColor
        phoneTF.layer.addSublayer(bottomLinePhone)
        phoneTF.placeholder = "Enter your NumberPhone"
        phoneTF.clearButtonMode = .whileEditing
        getOTPBtn.layer.cornerRadius = 6
        phoneTF.keyboardType = .namePhonePad
        setupPhoneSuccess()
    }
    private func setupPhoneSuccess() {
        errorPhone.isHidden = true
    }
    private func setupPhoneFail() {
        errorPhone.isHidden = false
        phoneTF.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.97, alpha: 1.00)
    }
    @IBAction func rememberPhone(_ sender: Any) {
        rememberTogle.toggle()
        if rememberTogle {
            rememberLogin.setImage(UIImage(named: "check"), for: .normal)
        } else {
            rememberLogin.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBAction func getOTP(_ sender: Any) {
        let numberPhoneText = phoneTF.text ?? ""
        var numberPhoneCheck: Bool = false
        if numberPhoneText.isEmpty {
            errorPhoneLb.text = "Numberphone can't Empty"
            setupPhoneFail()
        }else {
            setupPhoneSuccess()
            numberPhoneCheck = true
        }
        let isValidPhone = numberPhoneCheck
        if isValidPhone == true {
            loginPhoneWithFirebase()
            if rememberTogle == true {
                UserDefaults.standard.set("1", forKey: "rememberMe")
                UserDefaults.standard.set(phoneTF.text ?? "", forKey: "rememberPhone")
                print("Remember numberPhone")
            }else {
                UserDefaults.standard.set("2", forKey: "rememberMe")
            }
        }
    }
    private func checkRememberLogin() {
        if UserDefaults.standard.string(forKey: "rememberMe") == "1" {
            rememberLogin.setImage(UIImage(named: "check"), for: .normal)
            rememberTogle = true
            self.phoneTF.text = UserDefaults.standard.string(forKey: "rememberPhone") ?? ""
        }else {
            rememberLogin.setImage(UIImage(named: "uncheck"), for: .normal)
            rememberTogle = false
        }
    }
    private func loginPhoneWithFirebase() {
        guard let numberPhoneText = phoneTF.text else {
            return
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(numberPhoneText, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("login fail\(error.localizedDescription)")
            }else if let verificationID = verificationID {
                let alertVeryfy = UIAlertController(title: "Note", message: "Send code your Phone", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
                    let gotoVeryCode = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VerificationPhoneViewController") as! VerificationPhoneViewController
                    gotoVeryCode.verificationID = verificationID
                    self.navigationController?.pushViewController(gotoVeryCode, animated: true)
                }
                alertVeryfy.addAction(action)
                self.present(alertVeryfy, animated: true)
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
        }
    }
}
extension LoginPhoneViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let phoneFormater = phoneTF.text else {
            return false
        }
        let newString = (phoneFormater as NSString).replacingCharacters(in: range, with: string)
        phoneTF.text = formatter(mask: "+XX XXX XXX XXXX", phoneNumber: newString)
        return false
    }
    func  formatter(mask: String, phoneNumber: String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result:String = ""
        var index = number.startIndex
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            }else {
                result.append(character)
            }
        }
        return result
    }
}
