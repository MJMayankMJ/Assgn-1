//
//  ViewController.swift
//  Assgn 1
//
//  Created by Mayank Jangid on 2/12/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        heightTextField.delegate = self
        weightTextField.delegate = self

        // Set keyboard types
        heightTextField.keyboardType = .numbersAndPunctuation
        weightTextField.keyboardType = .numbersAndPunctuation

        // Set return key behavior
        heightTextField.returnKeyType = .next
        weightTextField.returnKeyType = .done

        // Auto-focus the height field when the app starts
        DispatchQueue.main.async {
            self.heightTextField.becomeFirstResponder()
        }
        
        //to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    
    //dismiss keyboard function
    @objc func dismissKeyboard() {
            view.endEditing(true) 
        }


    // Handle return key behavior
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == heightTextField {
            weightTextField.becomeFirstResponder()
        } else if textField == weightTextField {
            textField.resignFirstResponder()
            calculateBMI()
        }
        return true
    }

    // Function to calculate BMI
    func calculateBMI() {
        guard let heightText = heightTextField.text, let height = Double(heightText),
              let weightText = weightTextField.text, let weight = Double(weightText), height > 0 else {
            resultLabel.text = "Invalid Input"
            return
        }
        
        let heightInMeters = height / 100 // Convert cm to meters
        let bmi = weight / (heightInMeters * heightInMeters)
        resultLabel.text = String(format: "BMI: %.2f", bmi)
    }
}

