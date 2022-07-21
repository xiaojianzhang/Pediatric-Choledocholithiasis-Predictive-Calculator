//
//  Q6ViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/22/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class Q6ViewController: UIViewController {

    @IBOutlet weak var TBTextField: UITextField!
    
    var TB = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TBTextField.text = TB
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TBTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            NotificationCenter.default.post(name: Notification.Name("TB"), object: TBTextField.text)
        }
    }
}
