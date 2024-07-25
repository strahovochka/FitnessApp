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
    private(set) var updatedUser: UserModel
    private(set) var user: UserModel
    private(set) var selectedOptions: [OptionModel] = [] {
        didSet {
            if !selectedOptions.isEmpty {
                updatedUser.userOptions = selectedOptions
            } else {
                updatedUser.userOptions = nil
            }
        }
    }
    private(set) var updatedUserName: String {
        didSet {
            if user.name != updatedUserName && !updatedUserName.isEmpty  {
                updatedUser = UserModel(email: user.email, id: user.id, name: updatedUserName, sex: user.sex, profileImage: updatedUser.profileImage, userOptions: updatedUser.userOptions)
            } else {
                updatedUser = UserModel(email: updatedUser.email, id: updatedUser.id, name: user.name, sex: updatedUser.sex, profileImage: updatedUser.profileImage, userOptions: updatedUser.userOptions)
            }
            self.update()
        }
    }
    var userPhoto: UIImage? {
        didSet {
            if let newImage = userPhoto, let data = newImage.getCompressedData(to: 900) {
                updatedUser.profileImage = data
            } else {
                updatedUser.profileImage = nil
            }
            self.update()
        }
    }
   
    var update: () -> Void = { }
    
    init(user: UserModel) {
        self.user = user
        self.updatedUser = user
        updatedUserName = user.name
        if let options = user.userOptions {
            selectedOptions = options
        }
    }
    
    //MARK: -Update checks
    func isNameChanged() -> Bool {
        updatedUser.name != user.name
    }
    
    func isOptionsChanged() -> Bool {
        if selectedOptions.isEmpty && user.userOptions == nil {
            return false
        }
        return selectedOptions != user.userOptions
    }
    
    func isOptionsValid() -> Bool {
        if !selectedOptions.isEmpty {
            return !selectedOptions.contains { $0.value == nil }
        }
        return true
    }
    
    //MARK: -Value updaters
    func updateSelectedOptions(with options: [OptionDataName]) {
        var newOptions: [OptionModel] = []
        OptionDataName.allCases.forEach { optionName in
            if options.contains(optionName) {
                if let selectedOption = selectedOptions.first(where: { $0.optionName == optionName}) {
                    newOptions.append(selectedOption)
                } else {
                    newOptions.append(OptionModel(optionName: optionName, isShown: true))
                }
            }
        }
        selectedOptions = newOptions
    }
    
    func updateOption(with model: OptionModel) {
        if let optionIndex = selectedOptions.firstIndex(where: { $0.optionName == model.optionName }) {
            selectedOptions[optionIndex] = model
        }
    }
    
    //MARK: -Upload method
    func uploadChanges(completition: @escaping () -> ()) {
        FirebaseService.shared.updateUser(updatedUser) { [weak self] response in
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
    
    
    
//MARK: -Navigation
    func getProfileImage() -> UIImage? {
        if let profileImageData = user.profileImage {
            return UIImage(data: profileImageData)
        }
        return .editProfile
    }
    
    func showImagePickerOptions(delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)) {
        coordinator?.showImagePickerOptions(delegate: delegate)
    }
    
    func goToOptions(delegate: OptionsPopUpDelegate, with selectedOptions: [OptionDataName]) {
        coordinator?.navigateToOptions(with: selectedOptions, delegate: delegate)
    }
}

extension ProfileViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        if tag == TextFieldType.name.rawValue {
            self.updatedUserName = newValue
        }
    }
}
