//
//  CustomTextField.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

final class CustomTextField: UIView {
    
    enum State {
        case unfilled
        case filled
        case error
    }

    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var textField: UITextField!
    var errorChecker: ((String) -> (Bool))?
    
    @IBInspectable var labelTitle: String = "Label" {
        didSet {
            self.label.text = labelTitle
        }
    }
    
    @IBInspectable var placeholderText: String = "Placeholder" {
        didSet{
            self.textField.text = nil
            self.textField.placeholder = placeholderText
        }
    }
    
    private var state: CustomTextField.State = .unfilled {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0) { [weak self] in
                if let self = self {
                    self.updateUI()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.textField, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        initialUISetup()
    }
    
    private func initialUISetup() {
        self.textField.layer.borderWidth = 1
        self.textField.layer.cornerRadius = 12
        self.textField.layer.masksToBounds = true
        self.textField.delegate = self
        self.backgroundColor = .clear
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        updateUI()
    }
    
    private func updateUI() {
        switch state {
        case .unfilled:
            self.label.textColor = .primaryWhite
            self.textField.layer.borderColor = UIColor.secondaryGray.cgColor
            self.textField.textColor = .primaryWhite
            self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholderText, attributes: [.foregroundColor: UIColor.secondaryGray])
        case .filled:
            self.label.textColor = .primaryWhite
            self.textField.layer.borderColor = UIColor.primaryWhite.cgColor
            self.textField.textColor = .primaryWhite
        case .error:
            self.label.textColor = .primaryRed
            self.textField.layer.borderColor = UIColor.primaryRed.cgColor
            self.textField.textColor = .primaryRed
        }
    }
    
    @IBAction private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            self.state = .unfilled
        } else {
            if let errorChecker = errorChecker, let text = textField.text, errorChecker(text) {
                self.state = .error
            } else {
                self.state = .filled
            }
        }
    }
    
    func getText() -> String? {
        return textField.text
    }
    
}

extension CustomTextField: UITextFieldDelegate {
    
}
