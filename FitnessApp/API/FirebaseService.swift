//
//  FirebaseService.swift
//  FitnessApp
//
//  Created by Jane Strashok on 08.07.2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

enum DataFields {
    enum User {
        case name(String)
        case email(String)
        case sex(String)
        case id(String)
        case profileImage(Data)
        
        var value: Any {
            switch self {
            case .name(let name):
                return name
            case .email(let email):
                return email
            case .sex(let sex):
                return sex
            case .id(let id):
                return id
            case .profileImage(let data):
                return data
            }
        }
        
        var identifier: String {
            switch self {
            case .name:
                return "userName"
            case .email:
                return "email"
            case .sex:
                return "sex"
            case .id:
                return "id"
            case .profileImage:
                return "profileImage"
            }
        }
    }
}

class FirebaseService: NSObject {
    
    private enum ErrorType: String {
        case noCurrentUser = "No authentificated user"
        case userWasNotCreated = "No user created"
        case parseError = "Could not parse data"
        case fetchDataError = "Could not retrieve data"
        case encodingError = "Could not encode object"
    }
    
    enum Response<T: Any> {
        case success(T)
        case failure(String)
        case unknown
    }
    
    static let shared = FirebaseService()
    let firestore = Firestore.firestore()
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    func registerUser(_ userData: RegistrationModel, completition: @escaping (Response<Any>) -> ()) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { result, error in
            if let error = error {
                completition(.failure(error.localizedDescription))
                return
            }
            guard let user = result?.user else { return completition(.failure(ErrorType.userWasNotCreated.rawValue))}
            let data = [
                "email": userData.email as NSString,
                "id": user.uid as NSString,
                "sex": "" as NSString,
                "userName": userData.userName as NSString
            ]
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(data) { error in
                    if let error = error {
                        completition(.failure(error.localizedDescription))
                    } else {
                        completition(.success(true))
                    }
                }
        }
    }
    
    func setUserSex(_ sex: Sex, completition: @escaping (Response<Any>) -> ()) {
        if let user = currentUser {
            let document = firestore.collection("users").document(user.uid)
            document.updateData(["sex": sex.rawValue]) { error in
                if let error = error {
                    completition(.failure(error.localizedDescription))
                    return
                }
                completition(.success(true))
            }
        } else {
            completition(.failure(ErrorType.noCurrentUser.rawValue))
        }
    }
    
    func getUser(completition: @escaping (Response<UserModel>) -> () ) {
        if let user = currentUser {
            let userData = firestore.collection("users").document(user.uid)
            userData.getDocument { snapshot, error in
                if let error = error {
                    completition(.failure(error.localizedDescription))
                    return
                }
                if let data = snapshot?.data() {
                    if let name = data["userName"] as? String,
                       let sex = data["sex"] as? String,
                       let email = data["email"] as? String {
                        if let profileImage = data["profileImage"] as? Data {
                            completition(.success(UserModel(email: email, id: user.uid, name: name, sex: sex, profileImage: profileImage)))
                        } else {
                            completition(.success(UserModel(email: email, id: user.uid, name: name, sex: sex)))
                        }
                    } else {
                        completition(.failure(ErrorType.parseError.rawValue))
                    }
                } else {
                    completition(.failure(ErrorType.fetchDataError.rawValue))
                }
            }
        } else {
            completition(.failure(ErrorType.noCurrentUser.rawValue))
        }
    }
    
    func loginUser(withEmail: String, password: String, completition: @escaping (Response<UserModel>) -> ()) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { [weak self] result, error in
            if let error = error {
                completition(.failure(error.localizedDescription))
                return
            }
            guard let self = self else { return }
            if result != nil {
                self.getUser { response in
                    completition(response)
                }
            } else {
                completition(.unknown)
            }
        }
    }
    
    func resetPassword(for email: String, completiton: @escaping (Response<Bool>) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completiton(.failure(error.localizedDescription))
                return
            }
            completiton(.success(true))
        }
    }
    
    func updateUser(fields: [DataFields.User], completition: @escaping (Response<Bool>) -> ()) {
        if let user = currentUser {
            let data: [String: Any] = fields.reduce(into: [:]) { partialResult, field in
                partialResult[field.identifier] = field.value
            }
            firestore
                .collection("users")
                .document(user.uid)
                .setData(data, merge: true) { error in
                    if let error = error {
                        completition(.failure(error.localizedDescription))
                        return
                    }
                    completition(.success(true))
                }
        } else {
            completition(.failure(ErrorType.noCurrentUser.rawValue))
        }
    }
}
