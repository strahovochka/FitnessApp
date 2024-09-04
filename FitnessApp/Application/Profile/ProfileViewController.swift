//
//  ProfileViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 20.07.2024.
//

import UIKit

final class ProfileViewController: BaseViewController {
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameTextField: CustomTextField!
    @IBOutlet weak private var explanationTextLabel: UILabel!
    @IBOutlet weak private var addOptionsButton: PlainButton!
    @IBOutlet weak private var optionsStackView: UIStackView!
    @IBOutlet weak private var deleteAccountButton: PlainButton!
    
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sex = Sex(rawValue: viewModel?.user.sex ?? "") {
            setBackground(for: sex)
        }
        showNavigationBar(backButtonEnabled: true)
        configSaveButton()
        viewModel?.update = { [weak self] in
            self?.reload()
        }
        configUI()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            viewModel?.userPhoto = image
        }
        self.dismiss(animated: true)
    }
}

extension ProfileViewController: OptionsPopUpDelegate {
    func selectOptions(_ options: [OptionDataName]) {
        viewModel?.updateSelectedOptions(with: options)
        configStackView()
        self.reload()
    }
}

private extension ProfileViewController {
    
    func reload() {
        if let model = viewModel {
            configImageView()
            if model.isOptionsValid() {
                navigationItem.rightBarButtonItem?.isEnabled = model.isSaveAllowed()
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    func configUI() {
        configImageView()
        self.title = viewModel?.title
        
        nameTextField.setType(viewModel?.textFieldData ?? .name)
        nameTextField.text = viewModel?.user.userName
        nameTextField.delegate = viewModel
        
        explanationTextLabel.text = viewModel?.explanationText
        explanationTextLabel.numberOfLines = 0
        
        addOptionsButton.setType(.filled)
        addOptionsButton.title = viewModel?.addOptionsButtonText
        configStackView()
        
        deleteAccountButton.setType(.alert)
        deleteAccountButton.title = viewModel?.deleteButtonText
    }
    
    func configSaveButton() {
        let saveButton = createNavButton(text: viewModel?.saveButtonText, selector: #selector(saveData), isEnabled: false)
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func configImageView() {
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.masksToBounds = true
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPhotoOptions)))
        if let profileImage = viewModel?.userPhoto {
            profileImageView.image = profileImage
            profileImageView.backgroundColor = .clear
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.primaryYellow.cgColor
        } else {
            profileImageView.image = .editProfile
            profileImageView.backgroundColor = .primaryWhite.withAlphaComponent(0.3)
            profileImageView.contentMode = .center
            profileImageView.layer.borderWidth = 0
        }
    }
    
    func configStackView() {
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let viewModel = viewModel {
            if viewModel.selectedOptions.isEmpty {
                explanationTextLabel.isHidden = false
                optionsStackView.isHidden = true
            } else {
                explanationTextLabel.isHidden = true
                optionsStackView.isHidden = false
                viewModel.selectedOptions.forEach { option in
                    let view = OptionView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.heightAnchor.constraint(equalToConstant: 70).isActive = true
                    view.config(with: option) { [weak self] optionModel in
                        guard let self = self else { return }
                        self.viewModel?.updateOption(with: optionModel)
                    }
                    optionsStackView.addArrangedSubview(view)
                }
            }
        }
    }

    @objc func saveData() {
        view.endEditing(true)
        let isDataInvalid = optionsStackView.arrangedSubviews.compactMap { view in
            if let view = view as? OptionView {
                return view.checkForError()
            }
            return nil
        }.contains { $0 }
        if !isDataInvalid {
            navigationItem.rightBarButtonItem?.isEnabled = false
            viewModel?.uploadChanges()
        }
    }
    
    @objc func showPhotoOptions() {
        viewModel?.showImagePickerOptions(delegate: self)
    }
    
    @IBAction func addOptionsButtonPressed(_ sender: Any) {
        let selection: [OptionDataName] = optionsStackView.arrangedSubviews.compactMap { view in
            if let view = view as? OptionView {
                return view.getOption()
            }
            return nil
        }
        viewModel?.goToOptions(delegate: self, with: selection)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        viewModel?.goToDeleteAccount()
    }
}
