//
//  Calculate.swift
//  CountOnMe
//
//  Created by Thomas Bouges on 2019-01-18.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

protocol AlertSelectionDelegate {
    func alertOnActionButton (name: String, description: String)
}

class Calculate {

// MARK: - Properties
    var stringNumbers: [String]
    var operators: [String]
    var numbersDoubles: [Double]
    var number: Double
    var selectionDelegate : AlertSelectionDelegate?
    
    init() {
        stringNumbers = [String()]
        operators = ["+"]
        numbersDoubles = []
        number = 0.0
    }
    
    //test le true et false
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    selectionDelegate?.alertOnActionButton(name: "Zéro!", description: "Démarrez un nouveau calcul !")
                } else {
                    selectionDelegate?.alertOnActionButton(name: "Zéro!", description: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }
    
    //test true ou false
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                selectionDelegate?.alertOnActionButton(name: "Zéro!", description: "Expression incorrecte !")
                return false
            }
        }
        return true
    }
    
// MARK: - Methods
    //Test
    func calculateTotal() -> String {
        if !isExpressionCorrect {
            return " "
        }
        for (_, stringNumber) in stringNumbers.enumerated() {
            if let figure = Double(stringNumber) { numbersDoubles.append(figure)
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
        clear()
        return String(total)
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
                        selectionDelegate?.alertOnActionButton(name: "Division by Zéro!", description: "On ne peut pas diviser par zéro")
                        break
                    }else{
                        operateMultiDivAndTroncateArray(index: i, sign: "/")
                    }
                }
            }
        }
       /* if operators[operators.count-1] == "/" {
            operateMultiDivAndTroncateArray(index: operators.count-1, sign: "/")
        }
        if operators[operators.count-1] == "x" {
            operateMultiDivAndTroncateArray(index: operators.count-1, sign: "*")
        }*/
    }
    
    func operateMultiDivAndTroncateArray(index:Int , sign: String) {
        if sign == "x"{
            number = numbersDoubles[index-1] * numbersDoubles[index]
        }else if sign == "/"{
            number = numbersDoubles[index-1] / numbersDoubles[index]
        }
        numbersDoubles[index-1] = 0.0
        numbersDoubles[index] = number
        operators[index] = "+"
        
    }
    
    func updateDisplay() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        return text
    }
    //test
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        numbersDoubles = []
        number = 0.0
    }
    //Test
    func addNewNumber(_ newNumber: Int) ->String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return String(newNumber)
    }
    //Test
    func addNewOperator(_ sign: String) ->String {
        if canAddOperator {
            operators.append(sign)
            stringNumbers.append("")
            //updateDisplay()
            return sign
        }
        return " "
    }
    //test
    func addDot() ->String {
        if let stringNumber = stringNumbers.last {
            if stringNumber.contains("."){
                selectionDelegate?.alertOnActionButton(name: "Une virgule en trop", description: "On ne peut pas utiliser 2 virgules")
            }else if let stringNumber = stringNumbers.last {
                var stringNumberMutable = stringNumber
                stringNumberMutable += "."
                stringNumbers[stringNumbers.count-1] = stringNumberMutable
            }
        }
        return "."
    }
}

