//
//  RegitstrationViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import Foundation

final class RegistrationViewModel: BaseViewModel<RegistrationCoordinator> {
    
    private enum Patterns {
        static let name = #"^[a-zA-Z0-9-''']+(?: [a-zA-Z0-9-''']+)*$"#
        static let email = #"^\S+@\S+\.\S+$"#
        static let password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    }
    
    enum CellType: Int, CaseIterable {
        case name
        case email
        case password
        case confirmPassword
        
        static let rowHeight: CGFloat = 71
        static let footerHeight: CGFloat = 89
        
        var title: String {
            switch self {
            case .name:
                return "Name"
            case .email:
                return "Email"
            case .password:
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
            case .password:
                return "Create password"
            case .confirmPassword:
                return "Enter password"
            }
        }
        
        var errorChecker: (String) -> (Bool) {
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
            case .password, .confirmPassword:
                return {
                    let regex = try! NSRegularExpression(pattern: Patterns.password)
                    return !regex.matches($0) || $0.isEmpty
                }
            }
        }
    }
    
    let title = "Superhero"
    let subtitle = "Create your account"
    private var userName: String = ""
    private var email: String = ""
    private(set) var password: String = ""
    private var passwordConfirmation: String = ""
    weak var delegate: RegistrationFooteViewDelegate?
    
    func getCells() -> [CellType] {
        CellType.allCases
    }
    
    func registerUser() {
        delegate?.enableSignUpButton(false)
        let user = RegistrationModel(userName: userName, email: email, sex: nil, password: password)
        FirebaseService.shared.registerUser(user) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.coordinator?.navigateToSplashScreen()
            case .failure(let errorMessage):
                self.coordinator?.showAlert(title: errorMessage, actions: ["Ok": .default])
                self.delegate?.enableSignUpButton(true)
            case .unknown:
                self.delegate?.enableSignUpButton(true)
            }
        }
    }
    
    func getEmptyData() -> [CellType] {
        var emptyCells = [CellType]()
        if userName.isEmpty {
            emptyCells.append(.name)
        }
        if email.isEmpty {
            emptyCells.append(.email)
        }
        if password.isEmpty {
            emptyCells.append(.password)
        }
        if passwordConfirmation.isEmpty {
            emptyCells.append(.confirmPassword)
        }
        return emptyCells
    }
}

extension RegistrationViewModel: TextFieldRegistrationDelegate {
    func updateValue(for type: CellType, as newValue: String) {
        switch type {
        case .name:
            userName = newValue
        case .email:
            email = newValue
        case .password:
            password = newValue
        case .confirmPassword:
            passwordConfirmation = newValue
        }
    }
}
