//
//  LogInViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 14.07.2024.
//

import UIKit

final class LogInViewController: BaseViewController {
    
    @IBOutlet var textFields: [CustomTextField]!
    @IBOutlet weak var forgotPasswordButton: PlainButton!
    @IBOutlet weak var loginButton: PlainButton!
    
    var viewModel: LogInViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
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
}

private extension LogInViewController {
    func configUI() {
        forgotPasswordButton.setType(.unfilled)
        loginButton.setType(.filled)
        if let viewModel = viewModel {
            for (index, data) in viewModel.textFieldsData.enumerated() {
                textFields[index].labelTitle = data.title
                textFields[index].placeholderText = viewModel.getPlaceholder(for: data)
                textFields[index].tag = data.rawValue
                textFields[index].delegate = viewModel
            }
        }
    }
}
