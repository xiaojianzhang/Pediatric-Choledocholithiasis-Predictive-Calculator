//
//  Helper.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/24/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import Foundation
import UIKit

func validateEmailandPassword(emailTextField: UITextField, passwordTextField: UITextField) -> String? {
    // Validate the data is correct. If everything is correct, this method return nil. Otherwise, it returns the error message.
    
    // Check emailTextField is fileld in
    if isEmpty(text: emailTextField.text) {
        return "Please fill in your email!"
    }
    
    // Check passwordTextField is filled in
    if isEmpty(text: passwordTextField.text) {
        return "Please fill in your password!"
    }
    
    // Check if the email is valid
    if !isValidEmail(email: emailTextField.text!) {
        return "Please make sure your email address is valid."
    }
    
    // Check if the password is valid
    if !isValidPassword(password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) {
        return "Please make sure your password has at least 8 Characters, contains 1 Alphabet and 1 Number."
    }
    
    return nil
}

func isEmpty(text: String?) -> Bool {
    if text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return true
    }
    else {
        return false
    }
}

func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
}

func isValidPassword(password: String) -> Bool {
    // Minimum 8 characters at least 1 Alphabet and 1 Number
    let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
}

func showAlert(title: String, message: String, view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    DispatchQueue.main.async {
        view.present(alert, animated: true, completion: nil)
    }
}
