//
//  SplashViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 06.07.2024.
//

import UIKit

final class SplashViewController: UIViewController {

    @IBOutlet weak private var gradientView: UIView!
    @IBOutlet weak private var manButton: PlainButton!
    @IBOutlet weak private var girlButton: PlainButton!
    @IBOutlet weak private var backgroundWomanImage: UIImageView!
    @IBOutlet weak private var backgroundManImage: UIImageView!
    
    var viewModel: SplashViewModel?
    
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
        manButton.isEnabled = false
        girlButton.isEnabled = false
        viewModel?.heroChosen(.male) { [weak self] isSuccessful in
            guard let self = self else { return }
            if !isSuccessful {
                self.manButton.isEnabled = true
            }
            
        }
    }
    
    @IBAction func superGirlButtonTapped(_ sender: Any) {
        girlButton.isEnabled = false
        manButton.isEnabled = false
        viewModel?.heroChosen(.female) { [weak self] isSuccessful in
            guard let self = self else { return }
            if !isSuccessful {
                self.girlButton.isEnabled = true
            }
            
        }
    }
    
}
