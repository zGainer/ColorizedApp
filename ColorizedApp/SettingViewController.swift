//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Eugene on 28.10.22.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var toolBar: UIToolbar!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var mainViewColor: UIColor!
    var delegate: SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }
    
    // Не работает с клавиатурой в тулбаре (не понял почему)
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        view.endEditing(true)
//    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        setViewColor()
        
        setOnSliderChange(sender)
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setMainViewColor(color: colorView.backgroundColor)
        
        dismiss(animated: true)
    }
    
    @IBAction func toolbarDoneTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    private func initialSetting() {
        let tap = UITapGestureRecognizer(target: view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        setSliders()
        setLabels()
        setTextFields()
        setViewColor()
    }
    
    private func setSliders() {
        guard let components = mainViewColor.cgColor.components else { return }
        
        redSlider.value = Float(components[0])
        greenSlider.value = Float(components[1])
        blueSlider.value = Float(components[2])
    }
    
    private func setLabels() {
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
    }
    
    private func setTextFields() {
        redTF.text = string(from: redSlider)
        greenTF.text = string(from: greenSlider)
        blueTF.text = string(from: blueSlider)
    }
    
    private func setOnSliderChange(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTF.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTF.text = string(from: greenSlider)
        case blueSlider:
            blueLabel.text = string(from: blueSlider)
            blueTF.text = string(from: blueSlider)
        default:
            break
        }
    }
    
    private func setViewColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func string (from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: - UITextFieldDelegate

extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = toolBar
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setOnEndEditing(textField)
        
        setViewColor()
    }
    
    private func setOnEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatNewValue = Float(newValue) else { return }
        
        switch textField {
        case redTF:
            redLabel.text = newValue
            redSlider.value = floatNewValue
        case greenTF:
            greenLabel.text = newValue
            greenSlider.value = floatNewValue
        case blueTF:
            blueLabel.text = newValue
            blueSlider.value = floatNewValue
        default:
            break
        }
    }
}
