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
    
    func goBackToLogin() {
        coordinator?.navigateBackToLogIn()
    }
}
