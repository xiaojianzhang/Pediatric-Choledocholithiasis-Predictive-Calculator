//
//  LoginViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/23/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var dontHaveAnAccountLabel: UILabel!
    
    @IBOutlet weak var signUpNowButton: UIButton!
    
    @IBOutlet weak var emailImage: UIImageView!
    
    @IBOutlet weak var passwordImage: UIImageView!
    
    @IBOutlet weak var forgetYourPassword: UIButton!
    
    @IBOutlet weak var guestLoginButton: UIButton!
    
    @IBOutlet weak var statisticsLabel: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.statisticsLabel.layer.borderWidth = 2.0
        self.statisticsLabel.layer.cornerRadius = 8
        
        self.spinner.isHidden = true
        self.spinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    @IBAction func signUpNowTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let error = validateEmailandPassword(emailTextField: emailTextField, passwordTextField: passwordTextField)
        
        if error != nil {
            // show pop up alert message
            showAlert(title: "Login Failed", message: error!, view: self)
        }
        else {
            // Validate the user email and password using Firebase Auth
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { (result, errorFromFirebase) in
                if let errorFromFirebase = errorFromFirebase {
                    // show pop up alert message
                    showAlert(title: "Login Failed", message: errorFromFirebase.localizedDescription, view: self)
                }
                else {
                    // Transition to the NavigationController
                    UIView.animate(withDuration: 1.5, animations: {
                        self.backgroundImage.alpha = 0.2
                        self.loginButton.alpha = 0.2
                        self.welcomeLabel.alpha = 0.2
                        self.dontHaveAnAccountLabel.alpha = 0.2
                        self.signUpNowButton.alpha = 0.2
                        self.emailImage.alpha = 0.2
                        self.passwordImage.alpha = 0.2
                        self.emailTextField.alpha = 0.2
                        self.passwordTextField.alpha = 0.2
                        self.forgetYourPassword.alpha = 0.2
                        self.guestLoginButton.alpha = 0.2
                        self.statisticsLabel.alpha = 0.2
                        
                        self.spinner.isHidden = false
                        self.spinner.startAnimating()
                    }, completion: { done in
                        if done {
                            self.transitionToNavigationController()
                        }
                    })
                }
            }
            
            
        }
    }
    
    @IBAction func guestLoginTapped(_ sender: UIButton) {
        // Transition to the NavigationController
        UIView.animate(withDuration: 1.5, animations: {
            self.backgroundImage.alpha = 0.2
            self.loginButton.alpha = 0.2
            self.welcomeLabel.alpha = 0.2
            self.dontHaveAnAccountLabel.alpha = 0.2
            self.signUpNowButton.alpha = 0.2
            self.emailImage.alpha = 0.2
            self.passwordImage.alpha = 0.2
            self.emailTextField.alpha = 0.2
            self.passwordTextField.alpha = 0.2
            self.forgetYourPassword.alpha = 0.2
            self.guestLoginButton.alpha = 0.2
            self.statisticsLabel.alpha = 0.2
            
            self.spinner.isHidden = false
            self.spinner.startAnimating()
        }, completion: { done in
            if done {
                self.transitionToNavigationController()
            }
        })
    }
    private func transitionToNavigationController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func resetPassword(_ sender: UIButton) {
        showForgetYourPasswordAlert()
    }
    
    private func showForgetYourPasswordAlert() {
        let alert = UIAlertController(title: "Reset Your Password", message: "Please enter your email address below. We will send you an email to reset your password", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Email"
        }
        let send = UIAlertAction(title: "Send", style: .default) { _ in
            if let emailTextField = alert.textFields?.first, let email = emailTextField.text {
                Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(send)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
