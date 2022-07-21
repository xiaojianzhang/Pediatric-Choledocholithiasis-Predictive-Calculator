//
//  Q4ViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/22/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class Q4ViewController: UIViewController {
    
    var weight = ""
    
    @IBOutlet weak var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weightTextField.text = weight
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        weightTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            NotificationCenter.default.post(name: Notification.Name("weight"), object: weightTextField.text)
        }
    }

}
