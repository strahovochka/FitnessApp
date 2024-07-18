//
//  PopUpViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 18.07.2024.
//

import Foundation

final class PopUpViewModel: BaseViewModel<PopUpCoordinator> {

    let title: String
    let defaultAction: () -> ()
    let defaultButtonTitle: String
    private(set) var leftButtonAction: (() -> ())?
    private(set) var leftButtonTitle: String?
    
    init(title: String, defaultButtonTitle: String, defaultAction: @escaping () -> ()) {
        self.title = title
        self.defaultButtonTitle = defaultButtonTitle
        self.defaultAction = defaultAction
    }
    
    func addAction(title: String, action: (() -> ())?) {
        leftButtonAction = action
        leftButtonTitle = title
    }
}
