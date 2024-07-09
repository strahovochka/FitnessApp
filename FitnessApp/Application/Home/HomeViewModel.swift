//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeViewModel: BaseViewModel<HomeCoordinator> {
    
    private(set) var sex: Sex
    
    init(sex: Sex) {
        self.sex = sex
    }
}
