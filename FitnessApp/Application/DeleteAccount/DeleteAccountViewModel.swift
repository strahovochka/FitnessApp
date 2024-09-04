//
//  DeleteAccountViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 02.08.2024.
//

import Foundation

final class DeleteAccountViewModel: BaseViewModel<DeleteAccountCoordinator> {
    let user: UserModel
    let navigationTitle = "Delete account"
    let fieldType: TextFieldType = .email
    let explanationText = "To delete your account, confirm your email."
    let deleteButtonText = "Delete"
    let popUpTitle = "Are you sure you want to delete your account?"
    
    var emailChecker: (String) -> (Bool) {
        { [weak self] text in
            guard let self = self else { return false }
            return text != self.user.email
        }
    }
    var disableDelete: (Bool) -> () = { _ in }
    init(user: UserModel) {
        self.user = user
    }
    
    func showDeleteAccountPopUp() {
        let cancelButtonConfig = PopUpButtonConfig(title: "Cancel", type: .unfilled) { [weak self] in
            guard let self = self else { return }
            self.goBack()
        }
        let okButtonConfig = PopUpButtonConfig(title: "Ok", type: .filled) { [weak self] in
            guard let self = self else { return }
            self.disableDelete(true)
            self.deleteAccount()
        }
        coordinator?.showPopUp(title: popUpTitle, type: .twoButtons((cancelButtonConfig, okButtonConfig)))
    }
    
    func deleteAccount() {
        FirebaseService.shared.deleteAccount { [weak self] response in
            guard let self = self else { return }
            let buttonConfig = PopUpButtonConfig(title: "Ok", type: .filled, action: nil)
            switch response {
            case .success:
                self.coordinator?.rebootApp()
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton(buttonConfig))
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknown error occured", type: .oneButton(buttonConfig))
            }
            self.disableDelete(false)
        }
    }
}
