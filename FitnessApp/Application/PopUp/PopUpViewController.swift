//
//  CustomPopUp.swift
//  FitnessApp
//
//  Created by Jane Strashok on 17.07.2024.
//

import UIKit

final class PopUpViewConrtoller: UIViewController {
    
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var viewModel: PopUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
}

private extension PopUpViewConrtoller {
    
    func configUI() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        containerView.backgroundColor = UIColor(hex: "#010102")
        containerView.layer.borderColor = UIColor.primaryWhite.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .primaryWhite
        titleLabel.text = viewModel?.title
        configButtons()
    }
    
    func configButtons() {
        let defaultButton = PlainButton()
        defaultButton.setType(.filled)
        defaultButton.title = viewModel?.defaultButtonTitle
        defaultButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.defaultAction()
        }), for: .touchUpInside)
        buttonStackView.addArrangedSubview(defaultButton)
        if let leftTitle = viewModel?.leftButtonTitle, let leftAction = viewModel?.leftButtonAction {
            let defaultButton = PlainButton()
            defaultButton.setType(.unfilled)
            defaultButton.title = leftTitle
            defaultButton.addAction(UIAction(handler: { _ in
                leftAction()
            }), for: .touchUpInside)
        }
    }
}
