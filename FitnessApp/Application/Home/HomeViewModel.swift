//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeViewModel: UserDependentViewModel<HomeCoordinator> {
    
    let heroPlaceholderName = "Hero"
    let namePlaceholder = "Name"
    
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
    
    func goToProfile() {
        if let user = user {
            coordinator?.navigateToProfile(with: user)
        }
    }
}
