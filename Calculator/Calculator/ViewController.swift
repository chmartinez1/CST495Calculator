//
//  ViewController.swift
//  Calculator
//
//  Created by Christian Martinez on 9/8/16.
//  Copyright © 2016 Christian Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var userTypedDot = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
        
        if(!userTypedDot && digit == "." || digit == "π"){
        display.text = display.text! + digit
        history.text = history.text! + digit
        }else{
            display.text = display.text! + digit
            history.text = history.text! + digit
            }
        }
        else{
            display.text = digit
            history.text = history.text! + digit
            userIsInTheMiddleOfTypingANumber = true
        }
        if(digit == "."){
            if (userTypedDot==false){
                userTypedDot = true
            }
        }
        
    }
    
    @IBAction func clear(_ sender: UIButton) {
        display.text = "0"
        history.text = ""
        brain.emptyStack()
        userIsInTheMiddleOfTypingANumber = false
        userTypedDot = false
    }
    
    @IBAction func operate(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result =  brain.preformOperation(symbol: operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
        
        
    }
    
    @IBAction func enter() {
       userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(operand: displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
        
    }
    

    var displayValue:Double {
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            
        }
    }
}

 
