//
//  CustomTextField.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

protocol CustomTextFieldDelegate {
    func updateValue(for tag: Int, as newValue: String)
}

final class CustomTextField: UIView {
    
    enum State {
        case unfilled
        case filled
        case error
    }

    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var textField: UITextField!
    var errorChecker: ((String) -> (Bool))?
    var delegate: CustomTextFieldDelegate?
    
    @IBInspectable var labelTitle: String? = "Label" {
        didSet {
            self.label.text = labelTitle
        }
    }
    
    @IBInspectable var placeholderText: String? = "Placeholder" {
        didSet {
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
    
    func checkForError() {
        if let text = textField.text, let errorCheck = errorChecker, errorCheck(text) {
            self.state = .error
        }
    }
    
    func getState() -> State {
        self.state
    }
}

//-MARK: Private functions
private extension CustomTextField {
    func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.textField, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        initialUISetup()
    }
    
    func initialUISetup() {
        self.textField.layer.borderWidth = 1
        self.textField.layer.cornerRadius = 12
        self.textField.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        updateUI()
    }
    
    func updateUI() {
        switch state {
        case .unfilled:
            self.label.textColor = .primaryWhite
            self.textField.layer.borderColor = UIColor.secondaryGray.cgColor
            self.textField.textColor = .primaryWhite
            self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholderText ?? "", attributes: [.foregroundColor: UIColor.secondaryGray])
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
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty {
                self.state = .unfilled
            } else {
                self.state = .filled
                delegate?.updateValue(for: self.tag, as: text)
            }
        }
    }
}
