//
//  LaunchViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/23/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchImageView: UIImageView!
    
    @IBOutlet weak var appTitle: UILabel!
    
    @IBOutlet weak var appSubTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now()+3.5, execute: {self.animate()})
    }

    private func animate() {
        UIView.animate(withDuration: 1.5, animations: {
            self.launchImageView.alpha = 0
            self.appTitle.text = ""
            self.appSubTitle.text = ""
        }, completion: { done in
            if done {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        })

    }
}
