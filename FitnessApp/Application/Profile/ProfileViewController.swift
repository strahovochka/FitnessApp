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
    
    var viewModel: ProfileViewModel?
    var delegate: UserDataChangable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true
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
            if !image.isEqual(profileImageView.image) {
                viewModel?.userPhoto = image
            }
        }
        self.dismiss(animated: true)
    }
}

private extension ProfileViewController {
    
    func reload() {
        if let model = viewModel {
            navigationItem.rightBarButtonItem?.isEnabled = model.isNameChanged()
            if let image = model.userPhoto {
                profileImageView.image = image
                navigationItem.rightBarButtonItem?.isEnabled = true
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
        nameTextField.text = viewModel?.user.name
        nameTextField.delegate = viewModel
        
        explanationTextLabel.text = viewModel?.explanationText
        explanationTextLabel.numberOfLines = 0
        
        addOptionsButton.setType(.filled)
        addOptionsButton.title = viewModel?.addOptionsButtonText
    }
    
    func configImageView() {
        if let _ = viewModel?.user.profileImage {
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.primaryYellow.cgColor
        }
    }
    
    @objc func saveData() {
        view.endEditing(true)
        navigationItem.rightBarButtonItem?.isEnabled = false
        viewModel?.uploadChanges { [weak self] in
            guard let self = self else { return }
            self.delegate?.fetchData()
        }
    }
    
    @objc func showPhotoOptions() {
        viewModel?.showImagePickerOptions(delegate: self)
    }
}
