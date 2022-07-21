//
//  Q10ViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/22/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class Q10ViewController: UIViewController {

    @IBOutlet weak var ALPTextField: UITextField!
    
    var ALP = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ALPTextField.text = ALP
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ALPTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            NotificationCenter.default.post(name: Notification.Name("ALP"), object: ALPTextField.text)
        }
    }
}
