//
//  BaseViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setBackground(for sex: Sex = .male) {
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        switch sex {
        case .female:
            imageView.image = .backgroundWomanFull
        case .male:
            imageView.image = .backgroundMan
        }
        imageView.center = view.center
        imageView.addGradient([.clear, .black], locations: [0.0, 0.7])
        imageView.addoverlay()
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
