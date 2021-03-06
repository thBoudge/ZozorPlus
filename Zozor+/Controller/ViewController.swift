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

    private let calculate =  Calculate()
    private var operationIsInProcess: Bool = false // Does we start a new operation tapping or not
    

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.selectionDelegate = self //to tell that protocol is implemented on this class and code is on it
    }
    
    // MARK: - Action

    @IBAction func operatorButtonAction(_ sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else {return}
       textView.text += calculate.addNewOperator(buttonTitle)
    }
   
    @IBAction func tappedNumberButton(_ sender: UIButton) {
         switch sender.tag {
         case 10 :
            cancel()
         case 11 :
            textView.text += calculate.addDot()
         default:
            //Start of Operation
            if !operationIsInProcess {
                textView.text = ""
                textView.text += calculate.addNewNumber(sender.tag)
                operationIsInProcess = true
            }else { // Operation already started
                textView.text += calculate.addNewNumber(sender.tag)
            }
        }
    }

    @IBAction func equal() {
        textView.text += "= " + calculate.calculateTotal()
        operationIsInProcess = false
    }
// MARK: - Methods
    
    // Function in order to cancel and start a new operation
    func cancel() {
        calculate.clear()
        textView.text = ""
    }
}

// MARK: - Extension
//Implementation of Method alertOnActionButton from Protocol AlertSelectionDelegate
extension ViewController : AlertSelectionDelegate {
    func alertOnActionButton (name: String, description: String){
        let alertVC = UIAlertController(title: name, message: description, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
