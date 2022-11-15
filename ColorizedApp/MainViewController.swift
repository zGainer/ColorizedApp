//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Eugene on 15.11.22.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setMainViewColor (color: UIColor?)
}

class MainViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else { return }
        
        settingVC.mainViewColor = mainView.backgroundColor
        settingVC.delegate = self
    }
}

// MARK: - SettingViewControllerDelegate

extension MainViewController: SettingViewControllerDelegate {
    func setMainViewColor(color: UIColor?) {
        mainView.backgroundColor = color
    }
}
