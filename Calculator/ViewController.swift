//
//  ViewController.swift
//  Calculator
//
//  Created by Marcelo Sampaio on 11/23/16.
//  Copyright © 2016 Marcelo Sampaio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var display: UILabel!
    
    private var userIsInTheMiddleOfTyping=false
    
    
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        let textCurrentltInDisplay = display.text!
        
        if userIsInTheMiddleOfTyping {
            display.text = textCurrentltInDisplay + digit
        }else{
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping=true

        print("touched \(digit) digit")
        
        
    }
    
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text=String(newValue)
            
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    
    
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping=false
        }
        
        
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
            
        }
        displayValue = brain.result
        

    }
}

