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
    
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        self.sexLabel.text = viewModel?.sex.rawValue
    }
}
