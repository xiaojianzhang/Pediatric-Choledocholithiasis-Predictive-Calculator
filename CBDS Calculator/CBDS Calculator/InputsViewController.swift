//
//  InputsViewController.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/20/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import UIKit

class InputsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var inputsTable: UITableView!
    
    private let sections = ["Demographic", "Labs", "Abdominal Ultrasound"]
    
    private let originalQuestions = [["Q1: Gender?", "Q2: Date of birth?", "Q3: Height (cm)?", "Q4: Weight (kg)?", "Q5: Hemolytic disease (e.g. sickle cell disease, hereditary spherocytosis)?"], ["*required  Q6: Total bilirubin (mg/dL)?", "Q7: Direct bilirubin (mg/dL)?", "*required  Q8: ALT (U/L)?", "Q9: AST (U/L)?", "*required  Q10: Alkaline phosphatase (U/L)?", "Q11: Lipase (U/L)?", "Q12: Amylase (U/L)?", "Q13: GGT (U/L)?"], ["Q14: DUCTAL stones present on ultrasound?", "*required  Q15: Common bile duct diameter (mm)?"]]
    
    private var questions = [["Q1: Gender?", "Q2: Date of birth?", "Q3: Height (cm)?", "Q4: Weight (kg)?", "Q5: Hemolytic disease (e.g. sickle cell disease, hereditary spherocytosis)?"], ["*required  Q6: Total bilirubin (mg/dL)?", "Q7: Direct bilirubin (mg/dL)?", "*required  Q8: ALT (U/L)?", "Q9: AST (U/L)?", "*required  Q10: Alkaline phosphatase (U/L)?", "Q11: Lipase (U/L)?", "Q12: Amylase (U/L)?", "Q13: GGT (U/L)?"], ["Q14: DUCTAL stones present on ultrasound?", "*required  Q15: Common bile duct diameter (mm)?"]]
    
    private let segueIdentifiers = [["Q1", "Q2", "Q3", "Q4", "Q5"], ["Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13"], ["Q14", "Q15"]]
    
    private var inputsData = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    
    let model = LogisticRegression()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "Save & Return",
                    style: .plain,
                    target: nil,
                    action: nil
                )
        
        // Do any additional setup after loading the view.
        
        // Circle Button
        submitButton.layer.cornerRadius = 0.5 * submitButton.bounds.size.width
        submitButton.clipsToBounds = true
        
        // Comform to protocol UITableViewDelegate
        inputsTable.delegate = self
        
        // Comform to protocol UITableViewDataSource
        inputsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Passing data between ViewControllers using NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("height"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("weight"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("TB"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("ALT"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("ALP"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("CBD"), object: nil)
        
        self.inputsTable.reloadData()
        }
    
    @objc func didGetNotification(_ notification: Notification) {
        let data = notification.object as! String?
        if let data = data {
            if notification.name == Notification.Name("height") {
                inputsData[2] = data
            }
            
            if notification.name == Notification.Name("weight") {
                inputsData[3] = data
            }
            
            if notification.name == Notification.Name("TB") {
                inputsData[5] = data
                questions[1][0] = originalQuestions[1][0] + "\nYour input value is \(data) mg/dL"
            }
            
            if notification.name == Notification.Name("ALT") {
                inputsData[7] = data
                questions[1][2] = originalQuestions[1][2] + "\nYour input value is \(data) U/L"
            }
            
            if notification.name == Notification.Name("ALP") {
                inputsData[9] = data
                questions[1][4] = originalQuestions[1][4] + "\nYour input value is \(data) U/L"
            }
            
            if notification.name == Notification.Name("CBD") {
                inputsData[14] = data
                questions[2][1] = originalQuestions[2][1] + "\nYour input value is \(data) mm"
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = questions[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 1, indexPath.row == 0 {
            changeAsteriskColor(label: cell.textLabel!)
        }
        
        if indexPath.section == 1, indexPath.row == 2 {
            changeAsteriskColor(label: cell.textLabel!)
        }
        
        if indexPath.section == 1, indexPath.row == 4 {
            changeAsteriskColor(label: cell.textLabel!)
        }
        
        if indexPath.section == 2, indexPath.row == 1 {
            changeAsteriskColor(label: cell.textLabel!)
        }
        
        return cell
    }
    
    private func changeAsteriskColor(label: UILabel!) {
        let text = label.text!
        let range = (text as NSString).range(of: "*required")
        let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.red], range: range)
        label.attributedText = attributedString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Q3" {
            let vc = segue.destination as! Q3ViewController
            vc.height = inputsData[2]
        }
        
        if segue.identifier == "Q4" {
            let vc = segue.destination as! Q4ViewController
            vc.weight = inputsData[3]
        }
        
        if segue.identifier == "Q6" {
            let vc = segue.destination as! Q6ViewController
            vc.TB = inputsData[5]
        }
        
        if segue.identifier == "Q8" {
            let vc = segue.destination as! Q8ViewController
            vc.ALT = inputsData[7]
        }
        
        if segue.identifier == "Q10" {
            let vc = segue.destination as! Q10ViewController
            vc.ALP = inputsData[9]
        }
        
        if segue.identifier == "Q15" {
            let vc = segue.destination as! Q15ViewController
            vc.CBD = inputsData[14]
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: segueIdentifiers[indexPath.section][indexPath.row], sender: self)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if let error = validateRequiredInputs() {
            showAlert(title: "Required Inputs Missing", message: error, view: self)
        }
        else {
            transitionToResults()
        }
    }
    
    
    private func transitionToResults() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "Model Inputs",
                    style: .plain,
                    target: nil,
                    action: nil
                )
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        
        var data = [Double]()
        for index in [5, 7, 9, 14] {
            if let element = Double(inputsData[index]) {
                data.append(element)
            }
        }
        print(model.predictProbability(features: data))
        vc.predictedClass = model.predictClass(features: data)
        vc.navigationItem.title = "Results"
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func validateRequiredInputs() -> String? {
        // Validate the inputs are correct. If everything is correct, this method return nil. Otherwise, it returns the error message.
        
        // Check Q6 is fileld in
        if inputsData[5] == "" {
            return "Please input Q6"
        }
        
        // Check Q8 is fileld in
        if inputsData[7] == "" {
            return "Please input Q8"
        }
        
        // Check Q10 is fileld in
        if inputsData[9] == "" {
            return "Please input Q10"
        }
        
        // Check Q15 is fileld in
        if inputsData[14] == "" {
            return "Please input Q15"
        }
        
        return nil
    }
}
