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
    @IBOutlet weak private var continueButton: PlainButton!
    @IBOutlet weak private var backToLoginButton: PlainButton!
    
    var viewModel: ForgotPasswordViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configUI()
    }
}

private extension ForgotPasswordViewController {
    func configUI() {
        guard let viewModel = viewModel else { return }
        mainTitleLabel.font = .boldFutura?.withSize(32)
        mainTitleLabel.text = viewModel.title
        
        subtitleLabel.font = .regularSaira?.withSize(24)
        subtitleLabel.text = viewModel.subtitle
        
        emailTextField.setType(viewModel.field)
        emailTextField.errorChecker = viewModel.field.getErrorChecker()
        emailTextField.delegate = viewModel
        
        explanationTextLabel.font = .lightSaira?.withSize(16)
        explanationTextLabel.numberOfLines = 0
        explanationTextLabel.text = viewModel.explanationText
        
        continueButton.setType(.filled)
        continueButton.title = viewModel.continueButtonText
        
        backToLoginButton.setType(.unfilled)
        backToLoginButton.title = viewModel.backToLoginButtonText
    }
    
    @IBAction func backToLoginButtonPressed(_ sender: Any) {
        viewModel?.goBack()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        view.endEditing(true)
        emailTextField.checkForError()
        if emailTextField.getState() != .error {
            continueButton.isActive = false
            viewModel?.resetPassword { [weak self] isSuccessful in
                guard let self = self else { return }
                self.continueButton.isActive = !isSuccessful
            }
        }
    }
}
