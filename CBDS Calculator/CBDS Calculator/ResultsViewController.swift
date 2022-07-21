//
//  ResultsViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/20/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    let sections = ["Calculator Prediction"]
    
    let texts = [["This child is less likely to have choledocholithiasis", "This child is highly likely to have choledocholithiasis"]]
    
    var predictedClass = 0
    
    @IBOutlet weak var resultsTable: UITableView!
    
    @IBOutlet weak var feedbackContact: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resultsTable.contentInsetAdjustmentBehavior = .never
        
        // Comform to protocol UITableViewDelegate
        resultsTable.delegate = self
        
        // Comform to protocol UITableViewDataSource
        resultsTable.dataSource = self
        
        // Remove redundant blank rows of resultsTable
        resultsTable.tableFooterView = UIView()
        
        // Feedback and Contacts
        feedbackContact.text = "The manuscript submission for creation of this model is currently in progress. If you have any feedback, please feel free to contacts us at: shengzhang@gatech.edu or reuven.zev.cohen@emory.edu"
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        else {
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else {
            return texts[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        if indexPath.section == 0, indexPath.row == 0 {
            cell.textLabel?.text = texts[indexPath.section][predictedClass]
        }
        else {
            cell.textLabel?.text = texts[indexPath.section][indexPath.row]
        }
        
        return cell
    }
}
