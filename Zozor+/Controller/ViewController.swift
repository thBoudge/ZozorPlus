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
        if let stringNumber = stringNumbers.last {
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

        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }

        textView.text = textView.text + "=\(total)"

        clear()
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
    }
}
