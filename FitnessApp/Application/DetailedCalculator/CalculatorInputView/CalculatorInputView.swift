//
//  CalculatorInputView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import UIKit

final class CalculatorInputView: UIView {
    @IBOutlet weak private var inputNameLabel: UILabel!
    @IBOutlet weak private var textField: CustomTextField!
    @IBOutlet weak private var metricLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    func config(with inputType: InputType, value: Double? = nil, delegate: CustomTextFieldDelegate? = nil) {
        inputNameLabel.text = inputType.name
        metricLabel.text = inputType.metricVale
        textField.tag = inputType.rawValue
        textField.delegate = delegate
        textField.errorChecker = { text in
            return text.isEmpty || Double(text) == 0.0
        }
        guard let value = value, value > 0 else { return }
        textField.text = value.roundedString(to: 1)
    }
    
    func checkForError() {
        textField.checkForError()
    }
    
    func isError() -> Bool {
        return textField.getState() == .error
    }
}

private extension CalculatorInputView {
    func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.calculatorInput, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        initialUISetup()
    }
    
    func initialUISetup() {
        inputNameLabel.textColor = .primaryWhite
        inputNameLabel.font = .systemFont(ofSize: 18)
        
        textField.setLabelHidden(true)
        textField.placeholderText = ""
        textField.keyboardType = .decimalPad
        
        metricLabel.font = .systemFont(ofSize: 18, weight: .medium)
        metricLabel.textColor = .secondaryGray
    }
}
