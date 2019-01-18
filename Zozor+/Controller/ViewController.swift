//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    var numbersDoubles: [Double] = []
    var number: Double = 0.0
    
    //logic Screen
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }
    
    
    // logique Operator
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }


    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action
    var operat: Operator!
    
    @IBAction func operatorButtonAction(_ sender: UIButton) {
      switch sender.tag {
        case 0:
            operat = .plus
            if canAddOperator {
                operators.append(operat.display)
                stringNumbers.append("")
                updateDisplay()
            }
        case 1:
            operat = .minus
            if canAddOperator {
                operators.append(operat.display)
                stringNumbers.append("")
                updateDisplay()
            }
        case 3:
            operat = .multiplicator
            if canAddOperator {
                operators.append(operat.display)
                stringNumbers.append("")
                updateDisplay()
            }
        case 4:
            operat = .division
            if canAddOperator {
                operators.append(operat.display)
                stringNumbers.append("")
                updateDisplay()
            }
        default:
            break
        }
        
    }
   
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
         switch sender.tag {
         case 0,1,2,3,4,5,6,7,8,9 :
            addNewNumber(sender.tag)
         case 10 :
            clear()
         case 11 :
            addDot()
         default:
            break
        }
    }

    @IBAction func equal() {
        calculateTotal()
    }


    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }
    
    //A revoir
    func addDot() {
        
        var noDot: Bool = true
        
       /* let start = stringNumbers.lastIndex(of: " ")
        
        for i in start...stringNumbers.count {
            
            if stringNumbers[i] == "." {
                    noDot = false
                }
            }*/
        
       for (i, stringNumber) in stringNumbers.enumerated().reversed(){
            
            if i == 0 {
                
                if stringNumber.contains("."){
                    noDot = false
                }
            }
        }
        
       /* for i in (0..<stringNumbers.enumerated()).reversed() {
         
            if stringNumbers[i] == " " {
                
            }
            
         }*/
        if noDot == false {
            let alertVC = UIAlertController(title: "Le chiffre possede deja une virgule", message: "On ne peut pas utiliser 2 virgules", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }else if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "."
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    // logic Calcul
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
       for (_, stringNumber) in stringNumbers.enumerated() {
           if let number = Double(stringNumber) { numbersDoubles.append(number)
            }
        }
        
       priorityMultiDivi()
        
        var total: Double = 0.0
        for i in 0..<numbersDoubles.count {
            number = numbersDoubles[i]
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
        }
        
       //demander explication (i, stringNumber)
       /* for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }*/

        textView.text = textView.text + "=\(total)"

        clear()
    }

    func priorityMultiDivi() {
        
        for i in 1..<operators.count {
            if i < operators.count {
                number = numbersDoubles[i-1]
                if operators[i] == "x" {
                    operateMultiDivAndTroncateArray(index: i, sign: "x")
                    
                }else if operators[i] == "/" {
                    // error if divided by zero
                    if numbersDoubles[i] == 0 {
                        let alertVC = UIAlertController(title: "Division by Zéro!", message: "On ne peut pas diviser par zéro", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alertVC, animated: true, completion: nil)
                        break
                        
                    }else{
                        operateMultiDivAndTroncateArray(index: i, sign: "/")
                    }}
            }
        }
        
        
        if operators.last == "/" {
            operateMultiDivAndTroncateArray(index: operators.count-1, sign: "/")
        }
        if operators.last == "x" {
            operateMultiDivAndTroncateArray(index: operators.count-1, sign: "*")
        }
        
    }
    
    func operateMultiDivAndTroncateArray(index:Int , sign: String) {
        if sign == "x"{
            number = numbersDoubles[index-1] * numbersDoubles[index]
        }else if sign == "/"{
            number = numbersDoubles[index-1] / numbersDoubles[index]
        }
    numbersDoubles[index-1] = number
    numbersDoubles.remove(at: index)
    operators.remove(at: index)
    
    }
    
    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
        numbersDoubles = []
        number = 0.0
    }
}
