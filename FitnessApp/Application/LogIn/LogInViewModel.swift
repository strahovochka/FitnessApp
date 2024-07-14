//
//  LogInViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 14.07.2024.
//

import Foundation

final class LogInViewModel: BaseViewModel<LogInCoordinator> {
    
    let textFieldsData: [TextFieldType] = [.email, .password]
    private var email: String = ""
    private var password: String = ""
}

extension LogInViewModel: CustomTextFieldDelegate {
    func updateValue(for tag: Int, as newValue: String) {
        let type = TextFieldType(rawValue: tag)
        if type == .email {
            email = newValue
        } else if type == .password {
            password = newValue
        }
    }
}
