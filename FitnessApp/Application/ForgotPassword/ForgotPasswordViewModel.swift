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
    
    func resetPassword(completition: @escaping (Bool) -> ()) {
        FirebaseService.shared.resetPassword(for: email) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.coordinator?.showPopUp(title: "The form has been sent to your e-mail", actions: ["Ok": .ok], handler: { [weak self] type in
                    guard let self = self else { return }
                    self.goBackToLogin()
                })
                completition(true)
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, actions: ["Ok": .ok, "Cancel": .cancel], handler: { [weak self] type in
                    guard let self = self else { return }
                    if type == .cancel {
                        self.goBackToLogin()
                    }
                })
                completition(false)
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknown error occured", actions: ["Ok": .ok])
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
