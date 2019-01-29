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

    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.selectionDelegate = self //pour dire que le protocole va etre implementé dans cette class et que le code est dans cette class
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
            if !operationIsInProcess {//a voir si variable a mettre dans le model************************************
                textView.text = ""
                textView.text += calculate.addNewNumber(sender.tag)
                operationIsInProcess = true
            }else {
                textView.text += calculate.addNewNumber(sender.tag)
            }
        }
    }

    @IBAction func equal() {
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
        present(alertVC, animated: true, completion: nil)
    }
}
