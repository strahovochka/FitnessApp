//
//  ChartCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 31.07.2024.
//

import UIKit

final class ChartCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let option: OptionModel
    
    init(navigationController: UINavigationController, option: OptionModel) {
        self.navigationController = navigationController
        self.option = option
    }
    
    func start() {
        let vc = ChartViewController.instantiate(from: Identifiers.Storyboard.chart)
        vc.hidesBottomBarWhenPushed = true
        let viewModel = ChartViewModel(option: option)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
