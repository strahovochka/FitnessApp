//
//  BaseViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

let screenSize = UIScreen.main.bounds

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        setBackground()
    }
    
    func setBackground(for sex: Sex = .male) {
        if let view = view.subviews.first as? UIImageView {
            view.image = sex.image
        } else {
            let imageView = UIImageView(frame: view.bounds)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = sex.image
            imageView.center = view.center
            imageView.addGradient([.clear, .primaryBlack], locations: [0.0, 0.7])
            imageView.addoverlay()
            view.addSubview(imageView)
            self.view.sendSubviewToBack(imageView)
        }
    }
    
    func removeBackground() {
        view.subviews.forEach { view in
            guard let view = view as? UIImageView else { return }
            view.removeFromSuperview()
        }
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
    
    func showNavigationBar(backButtonEnabled: Bool = false) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if backButtonEnabled {
            customizeBackButton()
        }
    }
    
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
}

private extension BaseViewController {
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
