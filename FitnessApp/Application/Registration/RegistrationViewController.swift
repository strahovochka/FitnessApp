//
//  RegistrationViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    @IBOutlet weak private var mainTitle: UILabel!
    @IBOutlet weak private var subtitle: UILabel!
    @IBOutlet private var textFields: [CustomTextField]!
    @IBOutlet weak private var logInButton: PlainButton!
    @IBOutlet weak private var signUpButton: PlainButton!
    @IBOutlet weak private var loginLabel: UILabel!
    
    var viewModel: RegistrationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        textFields.forEach { $0.checkForError() }
        guard let _ = textFields.first(where: { $0.getState() == .error}) else {
            self.signUpButton.isEnabled = false
            viewModel?.registerUser { [weak self] status in
                guard let self = self else { return }
                if !status {
                    self.signUpButton.isEnabled = true
                }
            }
            return
        }
    }
    
    @IBAction func loginButtonPresses(_ sender: Any) {
        viewModel?.goToLogin()
    }
    
}


//-MARK: Private functions
private extension RegistrationViewController {
    func configUI() {
        if let viewModel = viewModel {
            mainTitle.text = viewModel.title
            mainTitle.font = .boldFutura?.withSize(32)
            subtitle.text = viewModel.subtitle
            subtitle.font = .regularSaira?.withSize(24)
            let textFieldsData = viewModel.textFieldsData
            for (index, data) in textFieldsData.enumerated() {
                self.textFields[index].labelTitle = data.title
                self.textFields[index].placeholderText = data.placeholderText
                self.textFields[index].errorChecker = viewModel.getErrorChecker(for: data)
                self.textFields[index].tag = data.rawValue
                self.textFields[index].delegate = self.viewModel
            }
            signUpButton.setType(.filled)
            signUpButton.setTitle(viewModel.signInButtonText, for: .normal)
            loginLabel.text = viewModel.loginText
            loginLabel.font = .lightSaira
            logInButton.setType(.unfilled)
            logInButton.setTitle(viewModel.logInButtonText, for: .normal)
        }
    }
}
