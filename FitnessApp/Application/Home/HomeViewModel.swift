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
    var update: () -> () = { }
    
    init(user: UserModel? = nil) {
        self.user = user
    }
    
    func getProfileImage() -> UIImage? {
        if let profileImageData = user?.profileImage {
            return UIImage(data: profileImageData)
        }
        return .profileImage
    }
    
    func getVisibleOptions() -> [OptionModel] {
        if let options = user?.userOptions {
            return options.filter { $0.isShown ?? false }
        }
        return []
    }
    
    func getUser(completition: @escaping () -> ()) {
        FirebaseService.shared.getUser { [weak self] response in
            guard let self = self else { return }
            let buttonConfig = PopUpButtonConfig(title: "Ok", type: .filled, action: nil)
            switch response {
            case .success(let userModel):
                self.user = userModel
                completition()
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton(buttonConfig))
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknow error occured", type: .oneButton(buttonConfig))
            }
        }
    }
    
    func goToProfile() {
        if let user = user {
            coordinator?.navigateToProfile(with: user)
        }
    }
}
