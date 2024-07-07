//
//  SplashViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 06.07.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    weak var coordinator: SplashCoordinator?

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var manButton: PlainButton!
    @IBOutlet weak var girlButton: PlainButton!
    @IBOutlet weak var backgroundWomanImage: UIImageView!
    @IBOutlet weak var backgroundManImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        backgroundManImage.addoverlay()
        backgroundWomanImage.addoverlay()
        
        manButton.setType(.filled)
        girlButton.setType(.filled)
        
        manButton.setFont(.regularSaira?.withSize(18))
        girlButton.setFont(.regularSaira?.withSize(18))
        
        gradientView.addGradient([.clear, .black, .clear], locations: [0.0, 0.5, 1.0], frame: gradientView.bounds)
    }
    
    @IBAction func superManButtonTapped(_ sender: Any) {
        coordinator?.navigateToTabBar()
        sex = .male
    }
    
    @IBAction func superGirlButtonTapped(_ sender: Any) {
        coordinator?.navigateToTabBar()
        sex = .female
    }
    
}
