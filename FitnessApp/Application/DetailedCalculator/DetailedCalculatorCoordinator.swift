//
//  DetailedCalculatorCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import UIKit

final class DetailedCalculatorCoordinator: Coordinator {
    var navigationController: UINavigationController
    let sex: Sex
    let type: CalculatorType
    
    init(navigationController: UINavigationController, sex: Sex, type: CalculatorType) {
        self.navigationController = navigationController
        self.sex = sex
        self.type = type
    }
    
    func start() {
        let vc = DetailedCalculatorViewController.instantiate(from: Identifiers.Storyboard.detailedCalculator)
        vc.hidesBottomBarWhenPushed = true
        let viewModel = DetailedCalculatorViewModel(sex: sex, type: type)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToActivityPopUp(selectedActivityLevel: DailyCaloriesRateAtivity, delegate: ActivityLevelDelegate) {
        let child = ActivityPopUpCoordinator(navigationController: navigationController, activityLevel: selectedActivityLevel)
        child.delegate = delegate
        child.start()
    }
}
