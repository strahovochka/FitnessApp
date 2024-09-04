//
//  CustomPopUp.swift
//  FitnessApp
//
//  Created by Jane Strashok on 17.07.2024.
//

import UIKit

final class PopUpViewConrtoller: UIViewController {
    
    @IBOutlet weak private var labelImageView: UIImageView!
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var buttonStackView: UIStackView!
    @IBOutlet weak private var buttonStackWidth: NSLayoutConstraint!
    @IBOutlet weak private var mainStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var mainStackBottomConstraint: NSLayoutConstraint!
    var viewModel: PopUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

private extension PopUpViewConrtoller {
    
    func configUI() {
        view.backgroundColor = .primaryBlack.withAlphaComponent(0.7)
        containerView.backgroundColor = UIColor(hex: "#010102")
        containerView.layer.borderColor = UIColor.primaryWhite.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .primaryWhite
        titleLabel.text = viewModel?.title
        
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        configButtons()
    }
    
    func configButtons() {
        if let type = viewModel?.type {
            switch type {
            case .buttonless(let image):
                buttonStackView.isHidden = true
                labelImageView.image = image
                mainStackTopConstraint.constant = 27
                mainStackBottomConstraint.constant = 27
            case .oneButton(let buttonConfig):
                addButton(with: buttonConfig)
            case .twoButtons(let buttonTuple):
                let buttonArray = [buttonTuple.leftButton, buttonTuple.rightButton]
                buttonArray.forEach { config in
                    addButton(with: config)
                }
            }
        }
    }
    
    func addButton(with config: PopUpButtonConfig) {
        let button = PlainButton()
        button.setType(config.type)
        button.title = config.title
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.hide()
            if let action = config.action {
                action()
            }
        }), for: .touchUpInside)
        buttonStackView.addArrangedSubview(button)
        if buttonStackView.arrangedSubviews.count > 1 {
            buttonStackWidth.priority = UILayoutPriority(998)
        }
    }
    
    @objc func hide() {
        dismiss(animated: true)
        if let completition = viewModel?.completition {
            completition()
        }
    }
}
