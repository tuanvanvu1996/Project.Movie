//
//  VerificationPhoneViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit
import FirebaseAuth
class VerificationPhoneViewController: UIViewController {
    var verificationID: String?
    var timer: Timer?
    var secondRemaining = 60
    var isCountingDown = false
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp5: UITextField!
    @IBOutlet weak var otp6: UITextField!
    @IBOutlet weak var countdownCode: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 6
        backBtn.layer.borderWidth = 1
        verifyBtn.layer.cornerRadius = 6
        otp1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otp2.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otp3.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otp4.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otp5.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otp6.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        startCountdown()
    }
    
    func startCountdown() {
        isCountingDown = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        secondRemaining -= 1
        countdownCode.text = "\(secondRemaining)s"
        if secondRemaining == 0 {
            stopCountdown()
        }
    }
    func stopCountdown() {
        isCountingDown = false
        timer?.invalidate()
        timer = nil
        secondRemaining = 60
    }
    @objc func textDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case otp1:
                otp2.becomeFirstResponder()
            case otp2:
                otp3.becomeFirstResponder()
            case otp3 :
                otp4.becomeFirstResponder()
            case otp4:
                otp5.becomeFirstResponder()
            case otp5:
                otp6.becomeFirstResponder()
            case otp6 :
                otp6.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case otp1:
                otp1.becomeFirstResponder()
            case otp2:
                otp1.becomeFirstResponder()
            case otp3:
                otp2.becomeFirstResponder()
            case otp4:
                otp3.becomeFirstResponder()
            case otp5:
                otp4.becomeFirstResponder()
            case otp6:
                otp5.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func resendOTP(_ sender: Any) {
        if !isCountingDown {
            startCountdown()
        }
    }
    
    @IBAction func verifiOTP(_ sender: Any) {
        showLoading(isShow: true)
        let verificationCode = "\(otp1.text ?? "")\(otp2.text ?? "")\(otp3.text ?? "")\(otp4.text ?? "")\(otp5.text ?? "")\(otp6.text ?? "")"
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Error verifying code \(error.localizedDescription)")
            }else {
                let gotoMainAlert = UIAlertController(title: "Note", message: "Login Success", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
                    let gotoMainNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
                    self.navigationController?.pushViewController(gotoMainNav, animated: true)
                }
                gotoMainAlert.addAction(action)
                self.present(gotoMainAlert, animated: true)
            }
        }
        
    }
}

