//
//  CustomPopUp.swift
//  FitnessApp
//
//  Created by Jane Strashok on 17.07.2024.
//

import UIKit

final class CustomPopUp: UIViewController {
    enum ButtonType {
        case ok
        case cancel
    }
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var buttonStackiew: UIStackView!
    
    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    init() {
        super.init(nibName: Identifiers.NibNames.popUp, bundle: nil)
        self.modalTransitionStyle = .coverVertical
        self.modalPresentationStyle = .overFullScreen
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    func addAction(title: String, type: ButtonType, handler: ((ButtonType) -> ())? = nil) {
        let button = PlainButton()
        switch type {
        case .ok:
            button.setType(.filled)
        case .cancel:
            button.setType(.unfilled)
        }
        button.title = title
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
            if let handler = handler {
                handler(type)
            }
        }), for: .touchUpInside)
        buttonStackiew.addArrangedSubview(button)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
}

private extension CustomPopUp {
    
    func configUI() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        containerView.backgroundColor = UIColor(hex: "#010102")
        containerView.layer.borderColor = UIColor.primaryWhite.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .primaryWhite
    }
}
