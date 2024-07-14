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

class FirebaseService: NSObject {
    
    enum Response<T> {
        case success(T?)
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
            guard let user = result?.user else { return completition(.failure("No user created"))}
            let data = [
                "email": userData.email as NSString,
                "id": user.uid as NSString,
                "sex": "" as NSString,
                "userName": userData.userName as NSString
            ]
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: data as [String : Any]) { error in
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
            completition(.failure("Unable to find user"))
        }
    }
    
    func getUser(completition: @escaping (Response<RegistrationModel>) -> Void ) {
        if let user = currentUser {
            let userData = firestore.collection("users").document(user.uid)
            userData.getDocument { snapshot, error in
                if let error = error {
                    completition(.failure(error.localizedDescription))
                }
                if let data = snapshot?.data() {
                    if let name = data["name"] as? String,
                       let sex = data["sex"] as? String,
                       let email = data["email"] as? String {
                        completition(.success(RegistrationModel(userName: name, email: email, sex: sex, password: "")))
                    } else {
                        completition(.failure("Could not parse data"))
                    }
                } else {
                    completition(.failure("Unable to get data for user"))
                }
            }
        } else {
            completition(.failure("No authentificated user"))
        }
    }
}
