//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Marcelo Sampaio on 11/23/16.
//  Copyright © 2016 Marcelo Sampaio. All rights reserved.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double{
    return op1 * op2
}
func divide(op1: Double, op2: Double) -> Double{
    return op1 / op2
}

// in this case add function was implemented as an eclousures "{}"
//func add(op1: Double, op2: Double) -> Double{
//    return op1 + op2
//}

func subtract(op1: Double, op2: Double) -> Double{
    return op1 - op2
}




class CalculatorBrain
{
    
    var accumulator = 0.0
    
    func setOperand (operand: Double){
        accumulator = operand
    }
    
    //
    // We can use enclosures instead of functions.
    // addition will be in this way. just to make an example of enclosures "{}"
    // add function could be killed, then
    //
    // In this case SWIFT inferrs that it is a function taken 2 parameter double and will return a double
    //
    var operations: Dictionary <String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation(multiply),  // multiply does not exists in swift. than I created it as as global function
        "÷" : Operation.BinaryOperation(divide),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation(subtract),
        "=" : Operation.Equals
    ]
    
    
    // new type  ENUM  and their associated values
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    
    func performOperation (symbol: String) {

        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedValue) :
                accumulator = associatedValue
            case .UnaryOperation(let associatedFunction) :
                accumulator = associatedFunction(accumulator)
            case .BinaryOperation(let function) :
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }

    }
    
    private func executePendingBinaryOperation() {
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending=nil
        }
    }
    
    private var pending : PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    
    // computed read-only property
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
