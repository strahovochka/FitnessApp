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
    let allowedChangeInterval: Int = 24*60*60
    let deleteButtonText = "Delete account"
    
    private(set) var updatedUser: UserModel
    private(set) var user: UserModel
    private(set) var selectedOptions: [OptionModel] = [] {
        didSet {
            if selectedOptions.isEmpty {
                updatedUser.userOptions = nil
            } else {
                updatedUser.userOptions = selectedOptions
            }
        }
    }
    private(set) var updatedUserName: String {
        didSet {
            if user.userName != updatedUserName && !updatedUserName.isEmpty  {
                updatedUser = UserModel(email: user.email, id: user.id, sex: user.sex, userName: updatedUserName, profileImage: updatedUser.profileImage, userOptions: updatedUser.userOptions)
            } else {
                updatedUser = UserModel(email: updatedUser.email, id: updatedUser.id, sex: updatedUser.sex, userName: user.userName, profileImage: updatedUser.profileImage, userOptions: updatedUser.userOptions)
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
        updatedUserName = user.userName
        if let profileImageData = user.profileImage {
            userPhoto = UIImage(data: profileImageData)
        }
        if let options = user.userOptions {
            selectedOptions = options
        }
    }
    
    
    //MARK: -Update checks
    func isOptionsValid() -> Bool {
        if !selectedOptions.isEmpty {
            return !selectedOptions.contains { $0.valueArray == [] }
        }
        return true
    }
    
    func isSaveAllowed() -> Bool {
        updatedUser != user 
    }
    
    //MARK: -Value updaters
    func updateSelectedOptions(with options: [OptionDataName]) {
        var newOptions: [OptionModel] = []
        OptionDataName.allCases.forEach { optionName in
            if options.contains(optionName) {
                if let selectedOption = selectedOptions.first(where: { $0.optionName == optionName }) {
                    newOptions.append(selectedOption)
                } else if let oldOption = user.userOptions?.first(where: { $0.optionName == optionName }) {
                    newOptions.append(oldOption)
                } else {
                    newOptions.append(OptionModel(optionName: optionName, valueArray: [], changedValue: nil, dateArray: [], isShown: true))
                }
            }
        }
        selectedOptions = newOptions
        self.update()
    }
    
    func updateOption(with updatedOption: OptionModel) {
        guard let selectedIndex = selectedOptions.firstIndex(where: { $0.optionName == updatedOption.optionName }) else { return }
        var newOption = updatedOption
        if updatedOption.valueArray.isEmpty || updatedOption.valueArray.count == 1 {
            selectedOptions[selectedIndex] = updatedOption
        } else {
            if let userIndex = user.userOptions?.firstIndex(where: { $0.optionName == updatedOption.optionName }),
                  let lastValue = updatedOption.valueArray.last ?? nil,
                  let lastSeledctedValue = user.userOptions?[userIndex].valueArray.last ?? nil,
                  let lastDate = updatedOption.dateArray.last,
                  let lastSeledctedDate = user.userOptions?[userIndex].dateArray.last {
                if lastValue != lastSeledctedValue, lastDate - lastSeledctedDate < allowedChangeInterval {
                    newOption.valueArray.remove(at: newOption.valueArray.count - 2)
                    newOption.dateArray.remove(at: newOption.dateArray.count - 2)
                }
                newOption.changedValue = newOption.getChangedValue()
                selectedOptions[selectedIndex] = newOption
            }
        }
        self.update()
    }
    
    //MARK: -Upload method
    func uploadChanges() {
        FirebaseService.shared.updateUser(user.getChangedFields(from: updatedUser)) { [weak self] response in
            guard let self = self else { return }
            let buttonConfig = PopUpButtonConfig(title: "Ok", type: .filled, action: nil)
            switch response {
            case .success:
                self.coordinator?.showPopUp(title: "Profile has been saved", type: .buttonless(.successIcon), completition: {
                    self.coordinator?.navigateBack()
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    UIView.animate(withDuration: 1.0) {
                        self.coordinator?.navigationController.presentedViewController?.view.alpha = 0
                    } completion: { _ in
                        self.coordinator?.dismiss()
                    }
                }
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton(buttonConfig))
            case .unknown:
                self.coordinator?.showPopUp(title: "An unkowm error occured", type: .oneButton(buttonConfig))
            }
        }
    }
    
//MARK: -Navigation
    func getProfileImage() -> UIImage? {
        guard let userPhoto = userPhoto else { return .editProfile }
        return userPhoto
    }
    
    func showImagePickerOptions(delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)) {
        coordinator?.showImagePickerOptions(delegate: delegate) { [weak self] in
            guard let self = self else { return }
            self.userPhoto = nil
        }
    }
    
    func goToOptions(delegate: OptionsPopUpDelegate, with selectedOptions: [OptionDataName]) {
        coordinator?.navigateToOptions(with: selectedOptions, delegate: delegate)
    }
    
    func goToDeleteAccount() {
        coordinator?.navigateToDeleteAccount(with: user)
    }
}

extension ProfileViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        if tag == TextFieldType.name.rawValue {
            self.updatedUserName = newValue
        }
    }
}
