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
        super.viewDidLoad()
        if let model = viewModel {
            if model.getUserSex() == "Supergirl" {
                setBackground(for: .female)
            } else {
                setBackground(for: .male)
            }
        }
        
        configUI()
    }
    
    private func configUI() {
        self.sexLabel.text = viewModel?.getUserSex()
        self.nameLabel.text = viewModel?.user.userName
    }
}
