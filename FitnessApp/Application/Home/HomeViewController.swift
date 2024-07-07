//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var sexLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        self.sexLabel.text = sex.rawValue
    }
}
