//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import Foundation
import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet weak private var sexLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    
    var viewModel: HomeViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        configUI()
        guard let _ = viewModel?.user else  {
            viewModel?.getUser { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
            return
        }
        updateUI()
    }
}

extension HomeViewController: UserDataChangable {
    func fetchData() {
        viewModel?.getUser(completition: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUI()
            }
        })
    }
}

private extension HomeViewController {
    func configUI() {
        sexLabel.text = viewModel?.heroPlaceholderName
        nameLabel.text = viewModel?.namePlaceholder
        sexLabel.font = .regularSaira?.withSize(24)
        nameLabel.font = .regularSaira?.withSize(16)
        profileButton.setImage(.profileImage, for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFill
        profileButton.layer.cornerRadius = 8
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = UIColor.primaryYellow.cgColor
        profileButton.layer.masksToBounds = true
    }
    
    func updateUI() {
        setBackground(for: viewModel?.getUserSex().sex ?? .male)
        self.sexLabel.text = viewModel?.getUserSex().title
        self.nameLabel.text = viewModel?.user?.name
        profileButton.setImage(viewModel?.getProfileImage(), for: .normal)
    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        viewModel?.goToProfile(delegate: self)
    }
    
}
