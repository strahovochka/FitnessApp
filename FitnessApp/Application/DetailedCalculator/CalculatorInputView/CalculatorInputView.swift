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
    
    func config(with inputType: InputType) {
        inputNameLabel.text = inputType.rawValue.capitalized
        metricLabel.text = inputType.metricVale
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
