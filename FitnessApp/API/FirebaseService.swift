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
    
    func updateUser(_ data: [String: Any], completition: @escaping (Response<Bool>) -> ()) {
        if let user = currentUser {
            firestore
                .collection("users")
                .document(user.uid)
                .setData(data, mergeFields: Array(data.keys)) { error in
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
    
    func deleteAccount(completition: @escaping (Response<Bool>) -> ()) {
        guard let user = currentUser else {
            completition(.failure(ErrorType.noCurrentUser.rawValue))
            return
        }
        user.delete { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                completition(.failure(error.localizedDescription))
                return
            }
            self.deleteDocument(with: user.uid, from: "users") { response in
                completition(response)
            }
        }
    }
    
    func deleteDocument(with id: String, from collection: String, completion: @escaping (Response<Bool>) -> ()) {
        firestore
            .collection(collection)
            .document(id)
            .delete { error in
                if let error = error {
                    completion(.failure(error.localizedDescription))
                    return
                }
                completion(.success(true))
            }
    }
}
