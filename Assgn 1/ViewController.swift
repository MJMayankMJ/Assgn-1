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
    
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var discoView: UIView!
    
    let discoColors: [UIColor] = [.red, .blue, .green, .yellow, .purple, .orange, .cyan, .magenta]
    var currentColorIndex = 0

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
        
        // Dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        heightSlider.minimumValue = 50
        heightSlider.maximumValue = 250
        weightSlider.minimumValue = 30
        weightSlider.maximumValue = 200

        heightSlider.value = 170
        weightSlider.value = 70

        heightTextField.text = "170"
        weightTextField.text = "70"

        // Setup circular disco view
        discoView.layer.cornerRadius = discoView.frame.size.width / 2
        discoView.clipsToBounds = true
        discoView.backgroundColor = .red
    }
    
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
    
    // Updates disco light when user does anything in text field
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateDiscoLight()
    }

    // Handle slider changes
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightTextField.text = String(Int(sender.value))
        updateDiscoLight()
        calculateBMI()
    }

    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightTextField.text = String(Int(sender.value))
        updateDiscoLight()
        calculateBMI()
    }

    // Handle text field changes
    @IBAction func heightTextFieldChanged(_ sender: UITextField) {
        if let height = Float(sender.text ?? "") {
            heightSlider.value = height
            updateDiscoLight()
        }
    }

    @IBAction func weightTextFieldChanged(_ sender: UITextField) {
        if let weight = Float(sender.text ?? "") {
            weightSlider.value = weight
            updateDiscoLight()
        }
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

    // Generate a random color
    func generateRandomColor() -> UIColor {
            return UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1.0
            )
        }

        // Function to animate the disco light color
        func updateDiscoLight() {
            UIView.animate(withDuration: 0.5) {
                self.discoView.backgroundColor = self.generateRandomColor()
            }
        }
}
