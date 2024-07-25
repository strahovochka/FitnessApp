//
//  UserModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 20.07.2024.
//

import Foundation

struct UserModel: Codable {
    let email: String
    let id: String
    let name: String
    let sex: String
    var profileImage: Data? = nil
    var userOptions: [OptionModel]? = nil
}
