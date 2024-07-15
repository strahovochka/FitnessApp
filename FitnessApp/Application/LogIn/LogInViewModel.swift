//
//  LogInViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 14.07.2024.
//

import Foundation

final class LogInViewModel: BaseViewModel<LogInCoordinator> {
    
    let textFieldsData: [TextFieldType] = []
    let title = "Superhero".uppercased()
    let subtitle = "Login to your account"
    let loginButtonText = "Login"
    let forgotPasswordText = "Forgot password?".capitalized
    private var email: String = ""
    private var password: String = ""
    
    func logIn(completition: @escaping (Bool) -> ()) {
        FirebaseService.shared.loginUser(withEmail: email, password: password) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let user):
                self.coordinator?.navigateToTabBar(with: user)
                completition(true)
            case .failure(let error):
                self.coordinator?.showAlert(title: error)
                completition(false)
            case .unknown:
                self.coordinator?.showAlert(title: "An unknown error occured")
                completition(false)
            }
        }
    }
}

extension LogInViewModel: CustomTextFieldDelegate {
    func updateValue(for tag: Int, as newValue: String) {
        let type = TextFieldType(rawValue: tag)
        if type == .email {
            email = newValue
        } else if type == .enterPassword {
            password = newValue
        }
    }
}
