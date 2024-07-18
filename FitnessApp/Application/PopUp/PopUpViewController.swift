//
//  CustomPopUp.swift
//  FitnessApp
//
//  Created by Jane Strashok on 17.07.2024.
//

import UIKit

final class PopUpViewConrtoller: UIViewController {
    
    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var buttonStackView: UIStackView!
    @IBOutlet weak private var buttonStackWidth: NSLayoutConstraint!
    
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
        if let leftTitle = viewModel?.leftButtonTitle, let leftAction = viewModel?.leftButtonAction {
            let leftButton = PlainButton()
            leftButton.setType(.unfilled)
            leftButton.title = leftTitle
            leftButton.addAction(UIAction(handler: { _ in
                leftAction()
            }), for: .touchUpInside)
            buttonStackWidth.priority = UILayoutPriority(998)
            buttonStackView.addArrangedSubview(leftButton)
        }
        let defaultButton = PlainButton()
        defaultButton.setType(.filled)
        defaultButton.title = viewModel?.defaultButtonTitle
        defaultButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.defaultAction()
        }), for: .touchUpInside)
        buttonStackView.addArrangedSubview(defaultButton)
    }
    
    @objc func hide() {
        dismiss(animated: true)
    }
}
