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
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
        display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation {
        case "×":performOperation{$0 * $1}
        case "÷":performOperation{$1 / $0}
        case "+":performOperation{$0 + $1}
        case "−":performOperation{$1 - $0}
        case "√":performOperation{sqrt($0)}
        case "sin":performOperation{$0}
        case "cos":performOperation{$0}
        case "π":performOperation{$0}
        default:break
        }
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
        operandStack.append(displayValue)
        userIsInTheMiddleOfTypingANumber = false
        print("operandStack = \(operandStack)")
        
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

 