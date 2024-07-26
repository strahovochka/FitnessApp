//
//  BaseViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

protocol UserDataChangable {
    func fetchData()
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        customizeNavBar()
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
        imageView.addGradient([.clear, .primaryBlack], locations: [0.0, 0.7])
        imageView.addoverlay()
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func createNavButton(text: String?, selector: Selector, isEnabled: Bool = true) -> UIBarButtonItem {
        let button = PlainButton(type: .unfilled)
        button.title = text
        button.setFont(.mediumSaira?.withSize(18))
        button.addTarget(self, action: selector, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        barButton.isEnabled = false
        return barButton
    }
    
    func customizeNavBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.mediumSaira?.withSize(18) ?? .systemFont(ofSize: 18),
            .foregroundColor: UIColor.primaryWhite
        ]
        customizeBackButton()
    }
}

private extension BaseViewController {
    
    func customizeBackButton() {
        let backView = UIStackView()
        backView.axis = .horizontal
        backView.alignment = .fill
        backView.spacing = 4
        backView.backgroundColor = .clear
        let backImage = UIImageView(image: .backIcon)
        backImage.contentMode = .center
        let backButton = PlainButton(type: .unfilled)
        backButton.setType(.unfilled)
        backButton.title = "Back"
        backButton.setFont(.mediumSaira?.withSize(18))
        backView.addArrangedSubview(backImage)
        backView.addArrangedSubview(backButton)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backView)
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
