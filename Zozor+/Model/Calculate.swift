//
//  Calculate.swift
//  CountOnMe
//
//  Created by Thomas Bouges on 2019-01-18.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

// protocol for all alert CountOnMe Application
protocol AlertSelectionDelegate {
    func alertOnActionButton (name: String, description: String)
}

class Calculate {

// MARK: - Properties
    private var stringNumbers: [String]
    private var operators: [String]
    private var numbersDoubles: [Double]
    private var number: Double
    var selectionDelegate : AlertSelectionDelegate?
    
    init() {
        stringNumbers = [String()]
        operators = ["+"]
        numbersDoubles = []
        number = 0.0
    }
    
    
    
    //Control if operate entered are correct before to use = (=without figure or 2+-3-2=)
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
    
    //Control if we can add a new operator or not (-2+3)
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
    
    //Method start when = is tapped
    func calculateTotal() -> String {
        if !isExpressionCorrect {
            return ""
        }
        //Create an Array of double from stringNumbers array
        for (_, stringNumber) in stringNumbers.enumerated() {
            if let figure = Double(stringNumber) { numbersDoubles.append(figure)
            }
        }
       
        var total: Double = 0.0
        
        if priorityMultiDivi(){
            for i in 0..<numbersDoubles.count {
                number = numbersDoubles[i]
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        
        clear()
        return String(total)
    }
    
    // Method to respect priority operation in order to start with x and /
    func priorityMultiDivi() -> Bool{
        for i in 1..<operators.count {
            if i < operators.count {
                number = numbersDoubles[i-1]
                if operators[i] == "x" {
                    operateMultiDivAndTroncateArray(index: i, sign: "x")
                }else if operators[i] == "/" {
                    // error if divided by zero
                    if numbersDoubles[i] == 0 {
                        selectionDelegate?.alertOnActionButton(name: "Division by Zéro!", description: "On ne peut pas diviser par zéro")
                        return false
                    }else{
                        operateMultiDivAndTroncateArray(index: i, sign: "/")
                    }
                }
            }
        }
        return true
    }
    
    //Method that multiplicate and divide figure and change numbersDouble to reflect result
    func operateMultiDivAndTroncateArray(index:Int , sign: String) {
        if sign == "x"{
            number = numbersDoubles[index-1] * numbersDoubles[index]
        }else if sign == "/"{
            number = numbersDoubles[index-1] / numbersDoubles[index]
        }
        // In case 2-2x9 if last sign is - before x or \ , in order to keep - 2-18
        if index == operators.count-1 && operators[index-1] == "-" {
            numbersDoubles[index-1] = 0.0 
            numbersDoubles[index] = number
            operators[index-1] = "+"
            operators[index] = "-"
        }else {
            numbersDoubles[index-1] = 0.0
            numbersDoubles[index] = number
            operators[index] = "+"
        }
        
        
    }
    
   //Method that clear all Properties In order to start new operation
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        numbersDoubles = []
        number = 0.0
    }
    
    //Method that add a number
    func addNewNumber(_ newNumber: Int) ->String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return String(newNumber)
    }
    
    //Method that add a new operator
    func addNewOperator(_ sign: String) ->String {
        if canAddOperator {
            operators.append(sign)
            stringNumbers.append("")
            return sign
        }
        return ""
    }
    
    // Method to add dot
    func addDot() ->String {
        if let stringNumber = stringNumbers.last {
            //control if a number is tap before
            if isExpressionCorrect {
                //control that there is no dot already tap on the figure
                if stringNumber.contains("."){
                    selectionDelegate?.alertOnActionButton(name: "Une virgule en trop", description: "On ne peut pas utiliser 2 virgules")
                    return ""
                }else if let stringNumber = stringNumbers.last { //all is correct we do add dot
                    var stringNumberMutable = stringNumber
                    stringNumberMutable += "."
                    stringNumbers[stringNumbers.count-1] = stringNumberMutable
                }
            }else {
                return ""
            }
        }
        return "."
    }
}

