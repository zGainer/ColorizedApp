//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Eugene on 28.10.22.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
        
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
    var toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        initialSetting()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        setViewColor()
        
        setOnSliderChange(sender)
    }
    
    @IBAction func doneButtonTapped() {
        guard let color = colorView.backgroundColor else { return }
        
        delegate.setMainViewColor(color)
        
        dismiss(animated: true)
    }
    
    @IBAction func toolbarDoneTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    private func initialSetting() {
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        colorView.layer.cornerRadius = 20
        
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

extension SettingViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let done = UIBarButtonItem(title: "Done",
                                   style: .plain,
                                   target: self,
                                   action: #selector(hideKeyboard))
        
        toolBar.items = [done]
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setOnEndEditing(textField)
        
        setViewColor()
    }
    
    private func setOnEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatNewValue = Float(newValue) else {
            showAlert(title: "Error", message: "Wrong format!")
            
            return
        }

        switch textField {
        case redTF:
            redLabel.text = newValue
            redSlider.setValue(floatNewValue, animated: true)
        case greenTF:
            greenLabel.text = newValue
            greenSlider.setValue(floatNewValue, animated: true)
        case blueTF:
            blueLabel.text = newValue
            blueSlider.setValue(floatNewValue, animated: true)
        default:
            break
        }
    }
}
