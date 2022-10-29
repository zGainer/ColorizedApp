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
        
        initialSetup()
    }

    @IBAction func changeRedSlider() {
        changeViewColor()
    }
    
    @IBAction func changeGreenSlider() {
        changeViewColor()
    }
    
    @IBAction func changeBlueSlider() {
        changeViewColor()
    }
    
    private func initialSetup() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        changeViewColor()
    }
    
    private func changeViewColor() {
        redLabel.text = getRounded(number: redSlider.value)
        greenLabel.text = getRounded(number: greenSlider.value)
        blueLabel.text = getRounded(number: blueSlider.value)
        
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func getRounded(number: Float) -> String {
        ( round(number * 1000) / 1000 ).formatted()
    }
}
