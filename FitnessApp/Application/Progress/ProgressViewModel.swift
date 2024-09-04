//
//  ProgressViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import Foundation

final class ProgressViewModel: UserDependentViewModel<ProgressCoordinator> {

    let navigationTitle = "Progress"
    let emptyStateText = "Options are not selected. To display them, add them to your profile."
    
    func isEmpty() -> Bool {
        guard let options = user?.userOptions else { return true}
        return options.isEmpty
    }
    
    func getOptions() -> [OptionModel] {
        guard let options = user?.userOptions, !options.isEmpty else { return [] }
        return options
    }
    
    func goToChart(for option: OptionModel) {
        coordinator?.navigateToChart(for: option)
    }
}
