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
    
    func resetPassword(completition: @escaping (Bool) -> ()) {
        FirebaseService.shared.resetPassword(for: email) { [weak self] response in
            guard let self = self else { return }
            let okButtonConfig = PopUpButtonConfig(title: "Ok", type: .filled, action: nil)
            switch response {
            case .success:
                self.coordinator?.showPopUp(title: "The form has been sent to your e-mail", type: .oneButton(okButtonConfig))
                completition(true)
            case .failure(let error):
                let cancelButtonConfig = PopUpButtonConfig(title: "Cancel", type: .unfilled) {
                    self.goBack()
                }
                self.coordinator?.showPopUp(title: error, type: .twoButtons((cancelButtonConfig, okButtonConfig)))
                completition(false)
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknow error occured", type: .oneButton(okButtonConfig))
            }
        }
    }
}

extension ForgotPasswordViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        if tag == field.rawValue {
            email = newValue
        }
    }
}
