//
//  UserDependentViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 06.08.2024.
//

import Foundation

class UserDependentViewModel<T: Coordinator>: BaseViewModel<T> {
    var user: UserModel? {
        didSet {
            guard let _ = user else { return }
            self.update()
        }
    }
    var update: () -> () = {}
    
    init(user: UserModel? = nil) {
        self.user = user
        super.init()
        guard let _ = user else { return }
        self.getUser()
    }
    
    func getUser() {
        FirebaseService.shared.getUser { [weak self] response in
            guard let self = self else { return }
            let buttonConfig = PopUpButtonConfig(title: "Ok", type: .filled, action: nil)
            switch response {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton(buttonConfig))
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknown error occured", type: .oneButton(buttonConfig))
            }
        }
    }
}
