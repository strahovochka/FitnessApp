//
//  OptionsPopUpCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import UIKit

final class OptionsPopUpCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController
    let selection: [OptionDataName]
    let delegate: OptionsPopUpDelegate
    let transitionDelegate = PopupTransitioningDelegate()
    
    init(navigationController: UINavigationController, selection: [OptionDataName], delegate: OptionsPopUpDelegate) {
        self.navigationController = navigationController
        self.selection = selection
        self.delegate = delegate
    }
    
    func start() {
        let vc = OptionsPopUpViewController.instantiate(from: Identifiers.Storyboard.optionsPopUp)
        let viewModel = OptionsPopUpViewModel(selection: selection)
        viewModel.coordinator = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitionDelegate
        vc.viewModel = viewModel
        vc.delegate = delegate
        self.navigationController.present(vc, animated: true)
    }
}
