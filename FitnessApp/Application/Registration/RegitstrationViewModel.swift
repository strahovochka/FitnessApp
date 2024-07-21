//
//  RegitstrationViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import Foundation

enum TextFieldType: Int, CaseIterable {
    private enum Patterns {
        static let name = "^[a-zA-Z0-9-''']+(?: [a-zA-Z0-9-''']+)*$"
        static let email = #"^\S+@\S+\.\S+$"#
        static let password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    }
    
    case name
    case email
    case enterPassword
    case createPassword
    case confirmPassword
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .createPassword, .enterPassword:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
    
    var placeholderText: String {
        switch self {
        case .name:
            return "Enter name"
        case .email:
            return "Enter email"
        case .enterPassword:
            return "Enter password"
        case .createPassword:
            return "Create password"
        case .confirmPassword:
            return "Enter password"
        }
    }
    
    func getErrorChecker(whichMatches text: String? = nil) -> ((String) -> (Bool)) {
        switch self {
        case .name:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.name)
                return !regex.matches($0) || $0.isEmpty
            }
        case .email:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.email)
                return !regex.matches($0) || $0.isEmpty
            }
        case .createPassword, .enterPassword:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.password)
                return !regex.matches($0) || $0.isEmpty
            }
        case .confirmPassword:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.password)
                return text != $0 || !regex.matches($0) || $0.isEmpty
            }
        }
    }
    
}

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
            switch response {
            case .success:
                self.coordinator?.navigateToSplashScreen()
                completition(true)
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton((title: "Ok", type: .filled, action: nil)))
                completition(false)
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknow error occured", type: .oneButton((title: "Ok", type: .filled, action: nil)))
                completition(false)
            }
        }
    }
    
    func getErrorChecker(for type: TextFieldType) -> ((String) -> (Bool)) {
        type.getErrorChecker(whichMatches: password)
    }
    
    func goToLogin() {
        coordinator?.navigateToLogIn()
    }
}

extension RegistrationViewModel: CustomTextFieldDelegate {
    func updateValue(for tag: Int, as newValue: String) {
        let type = TextFieldType(rawValue: tag)
        switch type {
        case .name:
            userName = newValue
        case .email:
            email = newValue
        case .createPassword:
            password = newValue
        default:
            break
        }
    }
}
