//
//  ViewController.swift
//  Calculator
//
//  Created by Kalybay Zhalgasbay on 12.04.2022.
//

import UIKit

final class ViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet private weak var calculatorDisplay: UILabel!
    @IBOutlet private weak var clearButton: UIButton!
    
    // MARK: - Private properties
    private var isResultTouched = false
    private var isOperationTouched = false
    private var firstElement = String()
    private var secondElement = String()
    private var doOperation = String()
    private var signPressed = false
    
    private enum Operations: String {
        case add = "+"
        case subtruct = "-"
        case division = "/"
        case multiplication = "x"
        case percent = "%"
        case comma = ","
        case sign = "+/-"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction private func numbersTouched(_ sender: UIButton) {
        if(!isOperationTouched){
            if(firstElement.isEmpty || isResultTouched){
                firstElement = sender.currentTitle!
            } else {
                firstElement += sender.currentTitle!
            }
            calculatorDisplay.text = firstElement
            isResultTouched = false
        } else {
            if(secondElement.isEmpty){
                secondElement = sender.currentTitle!
            } else {
                secondElement += sender.currentTitle!
            }
            calculatorDisplay.text = secondElement
        }
        clearButton.setTitle("C", for: .normal)
    }
    
    @IBAction private func operationsTouched(_ sender: UIButton) {
        isOperationTouched = true
        secondElement.removeAll()
        
        switch(sender.currentTitle!){
        case Operations.add.rawValue:
            doOperation = Operations.add.rawValue
        case Operations.subtruct.rawValue:
            doOperation = Operations.subtruct.rawValue
        case Operations.multiplication.rawValue:
            doOperation = Operations.multiplication.rawValue
        case Operations.division.rawValue:
            doOperation = Operations.division.rawValue
        case Operations.percent.rawValue:
            calculatorDisplay.text = String(Double(firstElement)! / 100)
            firstElement = calculatorDisplay.text!
            isOperationTouched = false
        case Operations.comma.rawValue:
            if(firstElement.isEmpty){
                calculatorDisplay.text = "0."
            } else {
                calculatorDisplay.text! += "."
            }
            firstElement = calculatorDisplay.text!
            isOperationTouched = false
        case Operations.sign.rawValue:
            if let resultDisplay = calculatorDisplay.text {
                if(resultDisplay.first == "-"){
                    calculatorDisplay.text = String(resultDisplay.dropFirst())
                } else {
                    calculatorDisplay.text = "-\(resultDisplay)"
                }
                firstElement = calculatorDisplay.text!
            }
            isOperationTouched = false
        default:
            break
        }
    }
    
    @IBAction private func clearDisplay(_ sender: UIButton) {
        clearButton.setTitle("AC", for: .normal)
        calculatorDisplay.text = "0"
        isOperationTouched = false
        firstElement.removeAll()
        secondElement.removeAll()
    }

    @IBAction private func resultTouched(_ sender: UIButton) {
        isOperationTouched = false
        isResultTouched = true
        if(!firstElement.isEmpty && !secondElement.isEmpty){
            switch (doOperation) {
            case Operations.add.rawValue:
                calculatorDisplay.text = String(Double(firstElement)! + Double(secondElement)!)
            case Operations.subtruct.rawValue:
                calculatorDisplay.text = String(Double(firstElement)! - Double(secondElement)!)
            case Operations.multiplication.rawValue:
                calculatorDisplay.text = String((Double(firstElement)!) * (Double(secondElement)!))
            case Operations.division.rawValue:
                calculatorDisplay.text = String(Double(firstElement)! / Double(secondElement)!)
            default:
                break
            }
          //Saving result as value of first element for multiple "=" touches
            firstElement = calculatorDisplay.text!
            
          //   Showing only 6 digits of the result
            if let result = calculatorDisplay.text {
                if(result.count > 10 ){
                var tempResult: String
                let index1 = result.index(result.startIndex, offsetBy: 0)
                let index2 = result.index(result.startIndex, offsetBy: 10)
                tempResult = String(result[index1...index2])
                calculatorDisplay.text = tempResult
                }
            }
        }
          //  Deleting last .0 of the result
        
        if let result = calculatorDisplay.text {
            if(result.last == "0"){
                calculatorDisplay.text = String(result.dropLast(2))
            }
            if(result.last == "."){
                calculatorDisplay.text = String(result.dropLast())
            }
        }
    }
    
}

