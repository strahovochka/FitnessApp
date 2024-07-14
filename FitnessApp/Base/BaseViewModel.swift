//
//  BaseViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import Foundation

class BaseViewModel<T: Coordinator> {
    
    weak var coordinator: T?
}
