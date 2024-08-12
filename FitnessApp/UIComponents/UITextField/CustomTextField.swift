//
//  CustomTextField.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

enum TextFieldType: Int, CaseIterable {
    private enum Patterns {
        static let name = "^[a-zA-Z0-9-''']+(?: [a-zA-Z0-9-''']+)*$"
        static let email = #"^\S+@\S+\.\S+$"#
        static let password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    }
    
    case name
    case email
    case enterPassword
    case createPassword
    case confirmPassword
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .createPassword, .enterPassword:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
    
    var placeholderText: String {
        switch self {
        case .name:
            return "Enter name"
        case .email:
            return "Enter email"
        case .enterPassword:
            return "Enter password"
        case .createPassword:
            return "Create password"
        case .confirmPassword:
            return "Enter password"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .name, .enterPassword, .confirmPassword, .createPassword:
            return .default
        case .email:
            return .emailAddress
        }
    }
    
    func getErrorChecker(whichMatches text: String? = nil) -> ((String) -> (Bool)) {
        switch self {
        case .name:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.name)
                return !regex.matches($0) || $0.isEmpty
            }
        case .email:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.email)
                return !regex.matches($0) || $0.isEmpty
            }
        case .createPassword, .enterPassword:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.password)
                return !regex.matches($0) || $0.isEmpty
            }
        case .confirmPassword:
            return {
                let regex = try! NSRegularExpression(pattern: Patterns.password)
                return text != $0 || !regex.matches($0) || $0.isEmpty
            }
        }
    }
    
}

protocol CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String)
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
    
    var labelTitle: String? = "Label" {
        didSet {
            self.label.text = labelTitle
        }
    }
    
    var placeholderText: String? = "Placeholder" {
        didSet {
            self.textField.text = nil
            self.textField.placeholder = placeholderText
        }
    }
    
    var text: String? = nil {
        didSet {
            textField.text = text
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
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
    
    func getText() -> String? {
        textField.text
    }
    
    func setType(_ type: TextFieldType) {
        labelTitle = type.title
        placeholderText = type.placeholderText
        tag = type.rawValue
        keyboardType = type.keyboardType
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
        self.label.font = .systemFont(ofSize: 18)
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
                delegate?.updateValue(self, for: self.tag, as: "")
            } else {
                self.state = .filled
                delegate?.updateValue(self, for: self.tag, as: text)
            }
        }
    }
}
