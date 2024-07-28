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
    
    var viewModel: ProfileViewModel?
    var delegate: UserDataChangable?
    
    override func viewDidLoad() {
        if let sex = Sex(rawValue: viewModel?.user.sex ?? "") {
            setBackground(for: sex)
        }
        super.viewDidLoad()
        viewModel?.update = { [weak self] in
            self?.reload()
        }
        configUI()
    }
    
    override func customizeNavBar() {
        super.customizeNavBar()
        self.navigationItem.title = viewModel?.title
        let saveButton = createNavButton(text: viewModel?.saveButtonText, selector: #selector(saveData), isEnabled: false)
        self.navigationItem.rightBarButtonItem = saveButton
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
        profileImageView.backgroundColor = .primaryWhite.withAlphaComponent(0.3)
        profileImageView.image = viewModel?.getProfileImage()
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = viewModel?.user.profileImage == nil ? .center : .scaleAspectFill
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPhotoOptions)))
        configImageView()
        nameTextField.labelTitle = viewModel?.textFieldData.title
        nameTextField.text = viewModel?.user.userName
        nameTextField.delegate = viewModel
        explanationTextLabel.text = viewModel?.explanationText
        explanationTextLabel.numberOfLines = 0
        
        addOptionsButton.setType(.filled)
        addOptionsButton.title = viewModel?.addOptionsButtonText
        configStackView()
    }
    
    func configImageView() {
        if let profileImage = viewModel?.userPhoto {
            profileImageView.image = profileImage
            profileImageView.backgroundColor = .clear
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.primaryYellow.cgColor
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
                        self.reload()
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
            viewModel?.uploadChanges { [weak self] in
                guard let self = self else { return }
                self.delegate?.fetchData()
            }
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
}
