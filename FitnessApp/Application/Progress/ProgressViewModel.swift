//
//  ProgressViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import Foundation

final class ProgressViewModel: BaseViewModel<ProgressCoordinator> {
    private(set) var user: UserModel?
    let navigationTitle = "Progress"
    let emptyStateText = "Options are not selected. To display them, add them to your profile."
    var update: () -> () = { }
    
    init(user: UserModel? = nil) {
        self.user = user
    }
    
    func getUser(completition: @escaping () -> ()) {
        FirebaseService.shared.getUser { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let userModel):
                self.user = userModel
                completition()
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton((title: "Ok", type: .filled, action: nil)))
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknow error occured", type: .oneButton((title: "Ok", type: .filled, action: nil)))
            }
        }
    }
    
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
