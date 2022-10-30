//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Eugene on 28.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSliders()
        
        setupLabels()
        
        setupView()
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        setupView()
                
        switch sender {
        case redSlider:
            redLabel.text = getRounded(number: redSlider.value)
        case greenSlider:
            greenLabel.text = getRounded(number: greenSlider.value)
        case blueSlider:
            blueLabel.text = getRounded(number: blueSlider.value)
        default:
            break
        }
    }
    
    private func setupLabels() {
        redLabel.text = getRounded(number: redSlider.value)
        greenLabel.text = getRounded(number: greenSlider.value)
        blueLabel.text = getRounded(number: blueSlider.value)
    }
    
    private func setupSliders() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func setupView() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func getRounded(number: Float) -> String {
        ( round(number * 1000) / 1000 ).formatted()
    }
}
