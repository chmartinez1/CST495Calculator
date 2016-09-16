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
    
    @IBAction func appendDigit(sender: UIButton) {
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
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        
        switch operation {
        case "×":
            self.history.text = history.text! + "x"
            performOperation{$0 * $1}
            
        case "÷":performOperation{$1 / $0}
            self.history.text = history.text! + "÷"
        case "+":performOperation{$0 + $1}
            self.history.text = history.text! + "+"
        case "−":performOperation{$1 - $0}
            self.history.text = history.text! + "-"
        case "√":performOperation{sqrt($0)}
            self.history.text = history.text! + "√"
        case "sin":performOperation{sin($0)}
            self.history.text = history.text! + "sin"
        case "cos":performOperation{cos($0)}
            self.history.text = history.text! + "cos"
        default:break
        }
        
    }
    
    @IBAction func clear(sender: UIButton) {
        operandStack.removeAll()
        display.text = "0"
        history.text = ""
        userIsInTheMiddleOfTypingANumber = false
        userTypedDot = false
    }
    var operandStack = Array<Double>()

    func performOperation(operation: (Double, Double) -> Double)
    {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
        
    }

    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        
    }


    @IBAction func enter() {
        if(display.text == "π"){
            operandStack.append(M_PI);
            userIsInTheMiddleOfTypingANumber = false
            print("operandStack = \(operandStack)")
        }else{
        operandStack.append(displayValue)
        userIsInTheMiddleOfTypingANumber = false
        print("operandStack = \(operandStack)")
        }
        
    }
    

    var displayValue:Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            
        }
    }
}

 