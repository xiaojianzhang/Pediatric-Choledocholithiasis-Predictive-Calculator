//
//  Q15ViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/22/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class Q15ViewController: UIViewController {

    
    @IBOutlet weak var CBDTextField: UITextField!
    
    var CBD = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CBDTextField.text = CBD
    }
    

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CBDTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            NotificationCenter.default.post(name: Notification.Name("CBD"), object: CBDTextField.text)
        }
    }

}
