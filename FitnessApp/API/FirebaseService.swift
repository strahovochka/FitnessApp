//
//  FirebaseService.swift
//  FitnessApp
//
//  Created by Jane Strashok on 08.07.2024.
//

import Foundation

class FirebaseService {
    static let shared = FirebaseService()
    
    private init() {}
}

extension FirebaseService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        self
    }
}
