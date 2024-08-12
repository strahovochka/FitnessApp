//
//  RegitstrationViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import Foundation

final class RegistrationViewModel: BaseViewModel<RegistrationCoordinator> {
    
    let textFieldsData: [TextFieldType] = [.name, .email, .createPassword, .confirmPassword]
    let title = "Superhero".uppercased()
    let subtitle = "Create your account"
    let signInButtonText = "Sign in"
    let loginText = "Already have an account?"
    let logInButtonText = "Login"
    private var userName: String = ""
    private var email: String = ""
    private var password: String = ""

    func registerUser(completition: @escaping (Bool) -> ()) {
        let user = RegistrationModel(userName: userName, email: email, sex: nil, password: password)
        FirebaseService.shared.registerUser(user) { [weak self] response in
            guard let self = self else { return }
            let buttonConfig = PopUpButtonConfig(title: "Ok", type: .filled, action: nil)
            switch response {
            case .success:
                self.coordinator?.navigateToSplashScreen()
                completition(true)
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton(buttonConfig))
                completition(false)
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknow error occured", type: .oneButton(buttonConfig))
                completition(false)
            }
        }
    }
    
    func getErrorChecker(for type: TextFieldType) -> ((String) -> (Bool)) {
        type.getErrorChecker()
    }
    
    func goToLogin() {
        coordinator?.navigateToLogIn()
    }
}

extension RegistrationViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        let type = TextFieldType(rawValue: tag)
        switch type {
        case .name:
            userName = newValue
        case .email:
            email = newValue
        case .createPassword:
            password = newValue
        case .confirmPassword:
            textField.errorChecker = type?.getErrorChecker(whichMatches: password)
        default:
            break
        }
    }
}
