//
//  UserModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 20.07.2024.
//

import Foundation
import FirebaseFirestore

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
    
    func toDic() -> [String: Any] {
        var dict = [String: Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
    
    func getChangedFields(from newUser: UserModel) -> [String: Any] {
        var data: [String: Any] = [:]
        if userName != newUser.userName { data["userName"] = newUser.userName as NSString }
        if profileImage != newUser.profileImage {
            if let newImage = newUser.profileImage {
                data["profileImage"] = newImage as Data
            } else {
                data["profileImage"] = FieldValue.delete()
            }
        }
        if userOptions != newUser.userOptions {
            guard let options = newUser.userOptions else {
                data["userOptions"] = FieldValue.delete()
                return data
            }
            var newUserOptions: [[String: Any]] = []
            for option in options {
                newUserOptions.append(option.getDictionary())
            }
            data["userOptions"] = newUserOptions
        }
        return data
    }
}
