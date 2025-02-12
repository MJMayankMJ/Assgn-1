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
    
    @IBOutlet weak var heightStepper: UIStepper!
    @IBOutlet weak var weightStepper: UIStepper!
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
        
        // To dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Set initial stepper values based on text fields
        heightStepper.value = Double(heightTextField.text ?? "170") ?? 170
        weightStepper.value = Double(weightTextField.text ?? "70") ?? 70

        // Configure stepper properties
        heightStepper.minimumValue = 50
        heightStepper.maximumValue = 250
        heightStepper.stepValue = 1

        weightStepper.minimumValue = 30
        weightStepper.maximumValue = 200
        weightStepper.stepValue = 1
    }
    
    // Dismiss keyboard
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

    // update height when stepper is changed and autocalculate bmi
    @IBAction func heightStepperChanged(_ sender: UIStepper) {
        heightTextField.text = String(Int(sender.value))
        calculateBMI()
    }

    // update weight when stepper is changed and autocalculate bmi
    @IBAction func weightStepperChanged(_ sender: UIStepper) {
        weightTextField.text = String(Int(sender.value))
        calculateBMI()
    }

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

