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
    private(set) var user: UserModel
    private(set) var updatedUserName: String
    var userPhoto: UIImage? {
        didSet {
            self.update()
        }
    }
    var update: () -> Void = { }
    
    init(user: UserModel) {
        self.user = user
        updatedUserName = user.name
    }
    
    func getProfileImage() -> UIImage? {
        if let profileImageData = user.profileImage {
            return UIImage(data: profileImageData)
        }
        return .editProfile
    }
    
    func showImagePickerOptions(delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)) {
        coordinator?.showImagePickerOptions(delegate: delegate)
    }
    
    func isNameChanged() -> Bool {
        if updatedUserName != user.name, !updatedUserName.isEmpty {
            return true
        }
        return false
    }
    
    func uploadChanges(completition: @escaping () -> ()) {
        var dataToUpdate: [DataFields.User] = []
        if user.name != updatedUserName {
            dataToUpdate.append(.name(updatedUserName))
        }
        if let newImage = userPhoto, let data = newImage.getCompressedData(to: 900) {
            dataToUpdate.append(.profileImage(data))
        }
        FirebaseService.shared.updateUser(fields: dataToUpdate) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.coordinator?.showPopUp(title: "Profile has been saved", type: .buttonless(.successIcon), completition: {
                    self.coordinator?.navigateBack()
                })
                completition()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    UIView.animate(withDuration: 1.0) {
                        self.coordinator?.navigationController.presentedViewController?.view.alpha = 0
                    } completion: { _ in
                        self.coordinator?.dismiss()
                    }
                }
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton((title: "Ok", type: .filled, action: nil)))
            case .unknown:
                self.coordinator?.showPopUp(title: "An unkowm error occured", type: .oneButton((title: "Ok", type: .filled, action: nil)))
            }
        }
    }
}

extension ProfileViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        if tag == TextFieldType.name.rawValue {
            self.updatedUserName = newValue
            self.update()
        }
    }
}
