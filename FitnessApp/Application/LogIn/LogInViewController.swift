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
}

private extension LogInViewController {
    func configUI() {
        forgotPasswordButton.setType(.unfilled)
        loginButton.setType(.filled)
        viewModel?.textFieldsData.forEach { data in
            textFields[data.rawValue].labelTitle = data.title
            textFields[data.rawValue].placeholderText = data.placeholderText
            textFields[data.rawValue].tag = data.rawValue
            textFields[data.rawValue].delegate = viewModel
        }
    }
}
