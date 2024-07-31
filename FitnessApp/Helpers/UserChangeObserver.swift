//
//  UserChangeObserver.swift
//  FitnessApp
//
//  Created by Jane Strashok on 31.07.2024.
//

import Foundation

protocol UserChangeObserver: AnyObject {
    func fetchUpdatedUser()
}

class UserChangeManager {
    static let shared = UserChangeManager()
    private var observers = [UserChangeObserver]()
    
    func add(observer: UserChangeObserver) {
        observers.append(observer)
    }
    
    func remove(observer: UserChangeObserver) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notify() {
        observers.forEach { $0.fetchUpdatedUser() }
    }
    
}
