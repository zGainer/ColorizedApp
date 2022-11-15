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
    
    var mainViewColor: UIColor!
    var delegate: SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSliders()
        setLabels()
        setViewColor()
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        setViewColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
        case blueSlider:
            blueLabel.text = string(from: blueSlider)
        default:
            break
        }
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setMainViewColor(color: colorView.backgroundColor)
        
        dismiss(animated: true)
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
