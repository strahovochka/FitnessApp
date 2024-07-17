//
//  LogInViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 14.07.2024.
//

import UIKit

final class LogInViewController: BaseViewController {
    
    @IBOutlet weak private var mainTitle: UILabel!
    @IBOutlet weak private var subtitle: UILabel!
    @IBOutlet private var textFields: [CustomTextField]!
    @IBOutlet weak private var forgotPasswordButton: PlainButton!
    @IBOutlet weak private var loginButton: PlainButton!
    @IBOutlet weak private var backToRegistrationButton: PlainButton!
    
    var viewModel: LogInViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

private extension LogInViewController {
    func configUI() {
        mainTitle.text = viewModel?.title
        mainTitle.font = .boldFutura?.withSize(32)
        subtitle.text = viewModel?.subtitle
        subtitle.font = .regularSaira?.withSize(24)
        if let viewModel = viewModel {
            for (index, data) in viewModel.textFieldsData.enumerated() {
                textFields[index].labelTitle = data.title
                textFields[index].placeholderText = data.placeholderText
                textFields[index].tag = data.rawValue
                textFields[index].delegate = viewModel
            }
        }
        forgotPasswordButton.setType(.unfilled)
        forgotPasswordButton.title = viewModel?.forgotPasswordText
        loginButton.setType(.filled)
        loginButton.title = viewModel?.loginButtonText
        backToRegistrationButton.setType(.unfilled)
        backToRegistrationButton.title = viewModel?.backToRegisterButtonText
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginButton.isEnabled = false
        viewModel?.logIn(completition: { [weak self] isSuccessful in
            guard let self = self else { return }
            if !isSuccessful {
                self.loginButton.isEnabled = true
            }
        })
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        viewModel?.goToForgotPassword()
    }
    
    @IBAction func backToRegisterButtonPressed(_ sender: Any) {
        viewModel?.goBackToRegister()
    }
}
