//
//  SignUpViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/23/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var emailImage: UIImageView!
    
    @IBOutlet weak var passwordImage: UIImageView!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var alreadyHaveAnAccount: UILabel!
    
    @IBOutlet weak var logInNow: UIButton!
    
    @IBOutlet weak var joinUs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
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
    
    @IBAction func loginNowTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        // Validate email and password
        let error = validateEmailandPassword(emailTextField: emailTextField, passwordTextField: passwordTextField)
        
        if error != nil {
            // show pop up alert message
            showAlert(title: "Sign Up Failed", message: error!, view: self)
        }
        else {
            // Create the user
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, errorFromFirebase) in
                // Check for erros
                if let errorFromFirebase = errorFromFirebase {
                    // show pop up alert message
                    showAlert(title: "Sign Up Failed", message: errorFromFirebase.localizedDescription, view: self)
                }
                else {
                    // Transition to the NavigationController
                    UIView.animate(withDuration: 1, animations: {
                        self.backgroundImage.alpha = 0.2
                        self.signUpButton.alpha = 0.2
                        self.joinUs.alpha = 0.2
                        self.alreadyHaveAnAccount.alpha = 0.2
                        self.logInNow.alpha = 0.2
                        self.emailImage.alpha = 0.2
                        self.passwordImage.alpha = 0.2
                        self.emailTextField.alpha = 0.2
                        self.passwordTextField.alpha = 0.2
                        
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
    
    private func transitionToNavigationController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
