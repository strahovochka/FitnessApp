//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeViewModel {
    
    private(set) var sex: Sex
    var coordinator: Coordinator?
    
    init(sex: Sex) {
        self.sex = sex
    }
}
