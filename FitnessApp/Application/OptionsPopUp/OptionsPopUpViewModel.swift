//
//  OptionsPopUpViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import Foundation

protocol OptionsPopUpDelegate: AnyObject {
    func selectOptions(_ options: [OptionDataName])
}

final class OptionsPopUpViewModel: BaseViewModel<OptionsPopUpCoordinator> {
    
    let title = "Select options"
    let cancelButtonText = "Cancel"
    let selectButtonText = "Select"
    private(set) var selection: Set<OptionDataName>
    
    init(selection: [OptionDataName]) {
        self.selection = Set(selection)
    }
    
    func addOption(_ option: OptionDataName) {
        selection.insert(option)
    }
    
    func removeOption(_ option: OptionDataName) {
        selection.remove(option)
    }
}
