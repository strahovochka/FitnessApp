//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak private var sexLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        configUI()
        if let model = viewModel {
            model.getUser { [weak self] user in
                guard let self = self else { return }
                self.updateUI()
            }
        }
    }
}

private extension HomeViewController {
    func configUI() {
        sexLabel.text = viewModel?.heroPlaceholderName
        nameLabel.text = viewModel?.namePlaceholder
        sexLabel.font = .regularSaira?.withSize(24)
        nameLabel.font = .regularSaira?.withSize(16)
    }
    
    func updateUI() {
        setBackground(for: viewModel?.getUserSex().sex ?? .male)
        self.sexLabel.text = viewModel?.getUserSex().title
        self.nameLabel.text = viewModel?.user?.userName
    }
}
