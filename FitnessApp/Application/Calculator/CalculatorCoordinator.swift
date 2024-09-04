//
//  CalculatorCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class CalculatorCoordinator: Coordinator {
    var navigationController: UINavigationController
    let user: UserModel?
    
    init(navigationController: UINavigationController, user: UserModel? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = CalculatorViewController.instantiate(from: Identifiers.Storyboard.calculator)
        let viewModel = CalculatorViewModel(user: user)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToCalculator(_ type: CalculatorType, _ sex: Sex) {
        let child = DetailedCalculatorCoordinator(navigationController: navigationController, sex: sex, type: type)
        child.start()
    }
}
