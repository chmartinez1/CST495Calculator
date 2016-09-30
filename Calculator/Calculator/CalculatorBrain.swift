//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Christian Martinez on 9/29/16.
//  Copyright © 2016 Christian Martinez. All rights reserved.
//

import Foundation
class CalculatorBrain{
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String, (Double) -> Double)
        case Constant(String, Double)
        case BinaryOperation(String,(Double,Double) -> Double)
        
        var description: String {
            switch self {
            case .Operand(let operand):
                let intValue = Int(operand)
                if Double(intValue) == operand {
                    return "\(intValue)"
                } else {
                    return "\(operand)"
                }
          
            case .UnaryOperation(let symbol, _):
                return symbol
            case .BinaryOperation(let symbol, _):
                return symbol
            case .Constant(let symbol, _):
                return "\(symbol)"
            }
        }
    }

    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    init(){
        knownOps["×"] = Op.BinaryOperation("×") {$0 * $1}
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+") {$0 + $1}
        knownOps["-"] = Op.BinaryOperation("-") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√",sqrt)
        knownOps["π"] = Op.Constant("π", M_PI)
        knownOps["sin"] = Op.UnaryOperation("sin", sin)
        knownOps["cos"] = Op.UnaryOperation("cos", cos)
    }
    
    private func evaluate(ops: [Op])-> (result:Double?,remainingOps: [Op])
    {
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
                
            case .Operand(let operand):
                return (operand,remainingOps)
                
            case .UnaryOperation(_,  let operation):
                let operandEvaluation = evaluate(ops: remainingOps)
                if let operand = operandEvaluation.result{
                    return(operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_,  let operation):
                let op1Evaluation = evaluate(ops: remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(ops: op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            case .Constant(_, let constantValue):
                return (constantValue, remainingOps)
            }
            
        }
        return(nil,ops)
    }
    
    private func evaluate() -> Double? {
        let (result, remainder) = evaluate(ops: opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func emptyStack() {
        opStack = [Op]()
    }
    
    func removeLastOpFromStack() {
        if opStack.last != nil {
            opStack.removeLast()
        }
    }
    
    func pushOperand(operand: Double)-> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    func pushConstant(operand: Double)-> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func preformOperation(symbol: String)-> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
}
