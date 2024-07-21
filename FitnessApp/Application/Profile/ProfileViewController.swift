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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true
        configUI()
    }
    
    override func customizeNavBar() {
        super.customizeNavBar()
        self.navigationItem.title = viewModel?.title
        let saveButton = createNavButton(text: viewModel?.saveButtonText, selector: #selector(saveData), isEnabled: false)
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
}

private extension ProfileViewController {
    
    func configUI() {
        profileImageView.backgroundColor = .primaryWhite.withAlphaComponent(0.3)
        profileImageView.image = viewModel?.getProfileImage()
        profileImageView.layer.cornerRadius = 8
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .center
        
        nameTextField.labelTitle = viewModel?.textFieldData.title
        nameTextField.text = viewModel?.user.name
        
        explanationTextLabel.text = viewModel?.explanationText
        explanationTextLabel.numberOfLines = 0
        
        addOptionsButton.setType(.filled)
        addOptionsButton.title = viewModel?.addOptionsButtonText
    }
    
    @objc func saveData() {
        
    }
}
