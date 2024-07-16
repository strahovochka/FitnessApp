//
//  ForgotPasswordViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.07.2024.
//

import Foundation

final class ForgotPasswordViewModel: BaseViewModel<ForgotPasswordCoodinator> {
    let title = "Superhero".uppercased()
    let subtitle = "Forgot password".capitalized
    let field: TextFieldType = .email
    let explanationText = "Enter the email address associated with your account and we'll send you a form to reset your password."
    let continueButtonText = "Continue"
    let backToLoginButtonText = "Back to login"
    
    private var email: String = ""
    
    func goBackToLogin() {
        coordinator?.navigateBackToLogIn()
    }
    
    func resetPassword() {
        FirebaseService.shared.resetPassword(for: email) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.coordinator?.showAlert(title: "The email was sent", actions: ["Ok": .default])
            case .failure(let error):
                self.coordinator?.showAlert(title: error, actions: ["Ok": .default])
            case .unknown:
                self.coordinator?.showAlert(title: "An unknown error occured")
            }
        }
    }
}

extension ForgotPasswordViewModel: CustomTextFieldDelegate {
    func updateValue(for tag: Int, as newValue: String) {
        if tag == field.rawValue {
            email = newValue
        }
    }
}
