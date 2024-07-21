//
//  ProfileViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 20.07.2024.
//

import UIKit

final class ProfileViewModel: BaseViewModel<ProfileCoordinator> {
    
    let title = "Profile"
    let explanationText = "Select an option to display on the main screen."
    let addOptionsButtonText = "Add options".capitalized
    let saveButtonText = "Save"
    let textFieldData: TextFieldType = .name
    var user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
    
    func getProfileImage() -> UIImage? {
        if let profileImageData = user.profileImage {
            return UIImage(data: profileImageData)
        }
        return .editProfile
    }
    
}
