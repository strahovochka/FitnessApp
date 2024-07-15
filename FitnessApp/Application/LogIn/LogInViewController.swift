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
        forgotPasswordButton.setTitle(viewModel?.forgotPasswordText, for: .normal)
        loginButton.setType(.filled)
        loginButton.setTitle(viewModel?.loginButtonText, for: .normal)
    }
}
