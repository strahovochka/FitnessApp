//
//  ActivityPopUpCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 15.08.2024.
//

import UIKit

final class ActivityPopUpCoordinator: Coordinator {
    var navigationController: UINavigationController
    let selectedActivityLevel: DailyCaloriesRateAtivity
    weak var delegate: ActivityLevelDelegate?
    let transitionDelegate = PopupTransitioningDelegate()
    
    init(navigationController: UINavigationController, activityLevel: DailyCaloriesRateAtivity) {
        self.navigationController = navigationController
        self.selectedActivityLevel = activityLevel
    }
    
    func start() {
        let vc = ActivityPopUpViewController.instantiate(from: Identifiers.Storyboard.activityPopUp)
        let viewModel = ActivityPopUpViewModel(selectedActivityLevel: selectedActivityLevel)
        viewModel.coordinator = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitionDelegate
        vc.viewModel = viewModel
        vc.delegate = delegate
        self.navigationController.present(vc, animated: true)
    }
}


