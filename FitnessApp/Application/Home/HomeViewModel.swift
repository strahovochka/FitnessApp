//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeViewModel: BaseViewModel<HomeCoordinator> {
    
    private(set) var user: UserModel?
    let heroPlaceholderName = "Hero"
    let namePlaceholder = "Name"
    
    init(user: UserModel? = nil) {
        self.user = user
    }
    
    func getProfileImage() -> UIImage? {
        if let profileImageData = user?.profileImage {
            return UIImage(data: profileImageData)
        }
        return nil
    }
    
    func getUserSex() -> (title: String, sex: Sex) {
        if let user = user {
            if user.sex == "female" {
                return ("Supergirl", .female)
            } else {
                return ("Superman", .male)
            }
        }
        return ("", .male)
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
    
    func goToProfile(delegate: UserDataChangable) {
        if let user = user {
            coordinator?.navigateToProfile(with: user, delegate: delegate)
        }
    }
}
