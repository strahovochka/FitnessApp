//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var checkBoxButton: CustomImageButton!
    @IBOutlet weak var radioButton: CustomImageButton!
    @IBOutlet weak var textField: CustomTextField!
    
    @IBOutlet weak var filledButton: PlainButton!
    
    @IBOutlet weak var unfilledButton: PlainButton!
    @IBOutlet weak var alertButton: PlainButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        self.textField.errorChecker = { text in
            if let text = text, text.count > 10 {
                return true
            }
            return false
        }
        
        self.checkBoxButton.setImaged(filled: .checkboxFilled, unfilled: .checkboxUnfilled)
        self.radioButton.setImaged(filled: .radioFilled, unfilled: .radioUnfilled)
        self.filledButton.setType(.filled)
        self.unfilledButton.setType(.unfilled)
        self.alertButton.setType(.alert)
        
    }
}
