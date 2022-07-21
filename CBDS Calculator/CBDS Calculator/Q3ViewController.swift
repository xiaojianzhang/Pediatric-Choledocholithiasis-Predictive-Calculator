//
//  Q3ViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/22/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class Q3ViewController: UIViewController{

    @IBOutlet weak var heightTextField: UITextField!
    
    var height = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        heightTextField.text = height
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            NotificationCenter.default.post(name: Notification.Name("height"), object: heightTextField.text)
        }
    }
    
}
