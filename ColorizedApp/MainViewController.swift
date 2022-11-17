//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Eugene on 15.11.22.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setMainViewColor (_ color: UIColor)
}

class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else { return }
        
        settingVC.mainViewColor = view.backgroundColor
        settingVC.delegate = self
    }
}

// MARK: - SettingViewControllerDelegate

extension MainViewController: SettingViewControllerDelegate {
    func setMainViewColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
