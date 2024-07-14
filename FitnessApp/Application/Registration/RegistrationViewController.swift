//
//  RegistrationViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    @IBOutlet private var textFields: [CustomTextField]!
    @IBOutlet weak private var logInButton: PlainButton!
    @IBOutlet weak private var signUpButton: PlainButton!
    
    var viewModel: RegistrationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.signUpButton.isEnabled = true
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        textFields.forEach { $0.checkForError() }
        guard let _ = textFields.first(where: { $0.getState() == .error}) else {
            self.signUpButton.isEnabled = false
            viewModel?.registerUser()
            return
        }
    }
}


//-MARK: Private functions
private extension RegistrationViewController {
    func configUI() {
        if let viewModel = viewModel {
            let textFieldsData = viewModel.getTextFieldsData()
            for data in textFieldsData {
                self.textFields[data.rawValue].labelTitle = data.title
                self.textFields[data.rawValue].placeholderText = data.placeholderText
                self.textFields[data.rawValue].errorChecker = viewModel.getErrorChecker(for: data)
                self.textFields[data.rawValue].tag = data.rawValue
                self.textFields[data.rawValue].delegate = self.viewModel
            }
            signUpButton.setType(.filled)
            logInButton.setType(.unfilled)
        }
    }
}
