//
//  SplashViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 06.07.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    weak var coordinator: SplashCoordinator?

    @IBOutlet weak var manButton: PlainButton!
    @IBOutlet weak var girlButton: PlainButton!
    @IBOutlet weak var backgroundWomanImage: UIImageView!
    @IBOutlet weak var backgroundManImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        backgroundManImage.addGradient(frame: backgroundManImage.bounds, direction: .bottomToTop)
        backgroundWomanImage.addGradient(frame: backgroundWomanImage.bounds, direction: .topToBottom)
        backgroundManImage.addoverlay(color: .black, alpha: 0.5)
        backgroundWomanImage.addoverlay(color: .black, alpha: 0.5)
        
        manButton.setType(.filled)
        girlButton.setType(.filled)
        
        manButton.setFont(.regularSaira?.withSize(18))
        girlButton.setFont(.regularSaira?.withSize(18))
    }
    
    @IBAction func superManButtonTapped(_ sender: Any) {
        coordinator?.navigateToTabBar()
    }
    
    @IBAction func superGirlButtonTapped(_ sender: Any) {
        coordinator?.navigateToTabBar()
    }
    
}
