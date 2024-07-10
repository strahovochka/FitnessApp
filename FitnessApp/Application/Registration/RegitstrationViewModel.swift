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
                    return regex.matches($0)
                }
            case .email:
                return {
                    let regex = try! NSRegularExpression(pattern: Patterns.email)
                    return regex.matches($0)
                }
            case .password, .confirmPassword:
                return {
                    let regex = try! NSRegularExpression(pattern: Patterns.password)
                    return regex.matches($0)
                }
            }
        }
    }
    
    let title = "Superhero"
    let subtitle = "Create your account"
    func getCells() -> [CellType] {
        CellType.allCases
    }
}
