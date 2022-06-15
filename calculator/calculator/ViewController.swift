//
//  ViewController.swift
//  calculator
//
//  Created by User on 11.06.2022.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var cleanButton: UIButton!
    
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var resultNumber: Double = 0
    var firstEntered = false
    var needCleanLabel = false
    var needAllClean = false
    var isFractionalNumber = false
    enum Operations{
        case div
        case mult
        case sub
        case add
        case nothing
    }
    var operation: Operations = .nothing
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            }
    
    func cleanLabel(){
        resultLabel.text! = "0"
        firstNumber = 0
        secondNumber = 0
        resultNumber = 0
        firstEntered = false
    }
    func division(){
        if secondNumber != 0 {
            resultNumber = firstNumber / secondNumber
        }
    }
    func multiple(){
        resultNumber = firstNumber * secondNumber
    }
    func substraction(){
        resultNumber = firstNumber - secondNumber
    }
    func addition(){
        resultNumber = firstNumber + secondNumber
    }
    func callOperation(){
        switch operation {
        case .div:
            division()
        case .mult:
            multiple()
        case .sub:
            substraction()
        case .add:
            addition()
        case .nothing:
            break
        }
        
    }
    func showResultNumber(){
        if resultNumber.truncatingRemainder(dividingBy: 1) == 0 {
            resultLabel.text = String(Int(resultNumber))
        } else{
            resultLabel.text = String(resultNumber)
        }
    }
    func checkDouble(){
        if resultLabel.text!.contains(","){
            isFractionalNumber = true
        } else {
            isFractionalNumber = false
        }
    }
    @IBAction func actionButtonClick(_ sender: UIButton) {
        let buttonTag: Int = sender.tag
        if buttonTag == 11 {
            cleanLabel()
        } else if (buttonTag == 12) || (buttonTag == 13){
            switch buttonTag{
            case 12:
                resultNumber = Double(resultLabel.text!)! * -1
            case 13:
                resultNumber = Double(resultLabel.text!)! / 100
            default:
                break
            }
            showResultNumber()
        }else if (buttonTag == 14) ||  (buttonTag == 15) || (buttonTag == 16) || (buttonTag == 17) || (buttonTag == 18){
            print(resultLabel.text)
            if !firstEntered {
                firstEntered = true
                firstNumber = Double(resultLabel.text!)!
                needCleanLabel = true
            } else {
                secondNumber = Double(resultLabel.text!)!
                callOperation()
                showResultNumber()
                firstNumber = resultNumber
                needCleanLabel = true
                }
            if buttonTag == 14{
                operation = .div
            }
            if buttonTag == 15{
                operation = .mult
            }
            if buttonTag == 16{
                operation = .sub
            }
            if buttonTag == 17{
                operation = .add
            }
            if buttonTag == 18{
                operation = .nothing
                needCleanLabel = true
                firstNumber = resultNumber
            }
        }
    }
    @IBAction func numberButtonClick(_ sender: UIButton) {
        let passedValue = String(sender.tag)
        checkDouble()
        
        if firstEntered && needCleanLabel{
            resultLabel.text! = "0"
            needCleanLabel = false
            if operation == .nothing{
                cleanLabel()
            }
        }
        if resultLabel.text == "0"{
            if passedValue != "10"{
                resultLabel.text = passedValue
            } else{
                resultLabel.text! += "."
            }
            
        } else {
            if passedValue != "10"{
                resultLabel.text! += passedValue
            } else if !isFractionalNumber{
                resultLabel.text! += "."
            }
            
        }
    }
}

