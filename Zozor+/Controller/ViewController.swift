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

    let calculate =  Calculate()
    var operationIsInProcess: Bool = false
    

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func operatorButtonAction(_ sender: UIButton) {
      switch sender.title(for: .normal) { //a revoir
        case "+":
            calculate.selectionDelegate = self
            textView.text += calculate.addNewOperator("+")
        case "-":
            calculate.selectionDelegate = self
            textView.text += calculate.addNewOperator("-")
        case "x":
            calculate.selectionDelegate = self
            textView.text += calculate.addNewOperator("x")
        case "/":
            calculate.selectionDelegate = self
            textView.text += calculate.addNewOperator("/")
        default:
            break
        }
        
    }
   
    @IBAction func tappedNumberButton(_ sender: UIButton) {
         switch sender.tag {
         case 10 :
            cancel()
         case 11 :
            calculate.selectionDelegate = self
            textView.text += calculate.addDot()
         default:
            calculate.selectionDelegate = self
            if !operationIsInProcess {
                textView.text = ""
                textView.text += calculate.addNewNumber(sender.tag)
                operationIsInProcess = true
            }else {
                textView.text += calculate.addNewNumber(sender.tag)
            }
        }
    }

    @IBAction func equal() {
        calculate.selectionDelegate = self
        textView.text += "= " + calculate.calculateTotal()
        operationIsInProcess = false
    }
// MARK: - Methods
    
    func cancel() {
        calculate.clear()
        textView.text = "0"
    }
}


extension ViewController : AlertSelectionDelegate {
    func alertOnActionButton (name: String, description: String){
        let alertVC = UIAlertController(title: name, message: description, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
