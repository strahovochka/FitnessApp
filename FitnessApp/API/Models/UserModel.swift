//
//  UserModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 20.07.2024.
//

import Foundation

struct UserModel: Codable, Equatable {
    let email: String
    let id: String
    let sex: String
    let userName: String
    var profileImage: Data? = nil
    var userOptions: [OptionModel]? = nil
    
    func getSex() -> Sex {
        guard sex == Sex.female.rawValue else { return .male }
        return .female
    }
}
