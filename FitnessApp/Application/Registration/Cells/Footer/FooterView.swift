//
//  FooterView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

protocol RegistrationFooteViewDelegate: NSObject {
    func enableSignUpButton(_ state: Bool)
}

final class FooterView: UIView {
    
    @IBOutlet weak private var signUpButton: PlainButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.registrationFooter, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        configUI()
    }
    
    private func configUI() {
        self.signUpButton.isHidden = false
        self.signUpButton.setType(.filled)
        self.isUserInteractionEnabled = true
    }
    
    func addAction(target: Any, _ action: Selector) {
        self.signUpButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension FooterView: RegistrationFooteViewDelegate {
    func enableSignUpButton(_ state: Bool) {
        self.signUpButton.isEnabled = state
    }
}
