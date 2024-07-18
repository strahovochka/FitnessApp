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
    @IBOutlet weak private var mainTitle: UILabel!
    @IBOutlet weak private var subtitle: UILabel!
    
    var viewModel: SplashViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @IBAction func superManButtonTapped(_ sender: Any) {
        manButton.isEnabled = false
        girlButton.isEnabled = false
        viewModel?.heroChosen(.male) { [weak self] isSuccessful in
            guard let self = self else { return }
            self.manButton.isEnabled = !isSuccessful
        }
    }
    
    @IBAction func superGirlButtonTapped(_ sender: Any) {
        girlButton.isEnabled = false
        manButton.isEnabled = false
        viewModel?.heroChosen(.female) { [weak self] isSuccessful in
            guard let self = self else { return }
            self.girlButton.isEnabled = !isSuccessful
        }
    }
}

private extension SplashViewController {
    func configUI() {
        backgroundManImage.addoverlay()
        backgroundWomanImage.addoverlay()
        backgroundManImage.image = .backgroundMan
        backgroundWomanImage.image = .backgroundWoman
        
        manButton.setType(.filled)
        girlButton.setType(.filled)
        manButton.setTitle(Sex.male.heroName, for: .normal)
        girlButton.setTitle(Sex.female.heroName, for: .normal)
        manButton.setFont(.regularSaira?.withSize(18))
        girlButton.setFont(.regularSaira?.withSize(18))
        
        mainTitle.text = viewModel?.title
        subtitle.text = viewModel?.subtitle
        mainTitle.font = .boldFutura?.withSize(32)
        subtitle.font = .thinSaira
        gradientView.addGradient([.clear, .primaryBlack, .clear], locations: [0.0, 0.5, 1.0], frame: gradientView.bounds)
    }
}
