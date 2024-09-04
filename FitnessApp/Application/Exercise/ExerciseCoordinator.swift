//
//  ExerciseCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.08.2024.
//

import UIKit

final class ExerciseCoordinator: Coordinator {
    var navigationController: UINavigationController
    let exercise: ExerciseModel
    
    init(navigationController: UINavigationController, exercise: ExerciseModel) {
        self.navigationController = navigationController
        self.exercise = exercise
    }
    
    func start() {
        let vc = ExerciseViewController.instantiate(from: Identifiers.Storyboard.exercise)
        vc.hidesBottomBarWhenPushed = true
        let viewModel = ExerciseViewModel(exercise: exercise)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}


