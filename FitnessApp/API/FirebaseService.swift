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
            let query = firestore.collection("users").whereField("id", isEqualTo: user.uid)
            query.getDocuments { snapshot, error in
                if let error = error {
                    completition(.failure(error.localizedDescription))
                    return
                }
                if let snapshot = snapshot {
                    snapshot.documents.forEach { document in
                        do {
                            let user = try document.data(as: UserModel.self)
                            completition(.success(user))
                        } catch {
                            completition(.failure(error.localizedDescription))
                        }
                        
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
    
    //TODO: update only changed fields
    func updateUser(_ user: UserModel, completition: @escaping (Response<Bool>) -> ()) {
        if let _ = currentUser {
            do {
                try firestore
                    .collection("users")
                    .document(user.id)
                    .setData(from: user) { error in
                        if let error = error {
                            completition(.failure(error.localizedDescription))
                            return
                        }
                        completition(.success(true))
                    }
            } catch {
                completition(.failure(error.localizedDescription))
            }
            
        } else {
            completition(.failure(ErrorType.noCurrentUser.rawValue))
        }
    }
}
