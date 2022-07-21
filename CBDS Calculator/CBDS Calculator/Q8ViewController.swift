//
//  Q8ViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/22/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class Q8ViewController: UIViewController {

    @IBOutlet weak var ALTTextField: UITextField!
    
    var ALT = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ALTTextField.text = ALT
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ALTTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            NotificationCenter.default.post(name: Notification.Name("ALT"), object: ALTTextField.text)
        }
    }
}
