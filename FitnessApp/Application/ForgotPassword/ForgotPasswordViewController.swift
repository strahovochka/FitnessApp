//
//  ForgotPasswordViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.07.2024.
//

import UIKit

final class ForgotPasswordViewController: BaseViewController {
    
    @IBOutlet weak private var mainTitleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    @IBOutlet weak private var emailTextField: CustomTextField!
    @IBOutlet weak private var explanationTextLabel: UILabel!
    @IBOutlet weak var continueButton: PlainButton!
    @IBOutlet weak var backToLoginButton: PlainButton!
    
    var viewModel: ForgotPasswordViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

private extension ForgotPasswordViewController {
    func configUI() {
        mainTitleLabel.font = .boldFutura?.withSize(32)
        mainTitleLabel.text = viewModel?.title
        subtitleLabel.font = .regularSaira?.withSize(24)
        subtitleLabel.text = viewModel?.subtitle
        emailTextField.labelTitle = viewModel?.field.title
        emailTextField.placeholderText = viewModel?.field.placeholderText
        emailTextField.errorChecker = viewModel?.field.getErrorChecker()
        emailTextField.delegate = viewModel
        emailTextField.tag = viewModel?.field.rawValue ?? TextFieldType.email.rawValue
        explanationTextLabel.font = .lightSaira?.withSize(16)
        explanationTextLabel.numberOfLines = 0
        explanationTextLabel.text = viewModel?.explanationText
        continueButton.setType(.filled)
        continueButton.title = viewModel?.continueButtonText
        backToLoginButton.setType(.unfilled)
        backToLoginButton.title = viewModel?.backToLoginButtonText
    }
    
    @IBAction func backToLoginButtonPressed(_ sender: Any) {
        viewModel?.goBackToLogin()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        view.endEditing(true)
        emailTextField.checkForError()
        if emailTextField.getState() != .error {
            continueButton.isEnabled = false
            viewModel?.resetPassword { [weak self] isSuccessful in
                guard let self = self else { return }
                self.continueButton.isEnabled = !isSuccessful
            }
        }
    }
}
