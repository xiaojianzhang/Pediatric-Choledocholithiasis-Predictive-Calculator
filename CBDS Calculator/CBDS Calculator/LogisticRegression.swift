//
//  LogisticRegression.swift
//  CBDS Calculator
//
//  Created by Zhang Sheng on 7/21/20.
//  Copyright © 2020 Sheng Zhang. All rights reserved.
//

import Foundation

class LogisticRegression {
    
    // The weights of logistic regression
    // Index 0: Intercept
    // Index 1: Total Bilirubin
    // Index 2: Alanine Aminotransferase (ALT)
    // Index 3: Alkaline Phosphatase (ALP)
    // Index 4: Ultrasound Common Bile Duct diameter
    private let weights = [-2.5847, 0.0602, 0.0034, 0.0014, 0.1413]
    
    private let threshold = 0.517
    
    // Sigmoid Function
    private func sigmoid(z: Double) -> Double {
        return 1.0 / (1.0 + exp(-z))
    }
    
    // Probability estimate for features.
    public func predictProbability(features x: [Double]) -> Double {
        
        var sum = weights[0]
        
        for i in 1..<weights.count {
            sum += x[i-1] * weights[i]
        }
        
        return sigmoid(z: sum)
    }
    
    // Predict class label for features.
    public func predictClass(features x: [Double]) -> Int {
        
        if predictProbability(features: x) >= threshold {
            return 1
        }
        else {
            return 0
        }
    }
    
}
