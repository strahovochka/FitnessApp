//
//  OptionView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import UIKit

final class OptionView: UIView {
    
    @IBOutlet weak private var optionSwitch: CustomSwitch!
    @IBOutlet weak private var unitLabel: UILabel!
    @IBOutlet weak private var textField: CustomTextField!
    private(set) var hasChanged: Bool = false
    private var model: OptionModel?
    private var updateAction: ((OptionModel) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    func config(with option: OptionModel, updateAction: ((OptionModel) -> ())?) {
        model = option
        optionSwitch.isOn = option.isShown ?? true
        
        if let lastElement = option.valueArray.last {
            if let value = lastElement {
                textField.text = String(value)
            } else {
                if option.valueArray.count > 1 {
                    textField.text = String(option.valueArray[option.valueArray.count - 2] ?? 0)
                    optionSwitch.isOn = true
                }
            }
        } else {
            textField.text = ""
        }
        textField.labelTitle = option.optionName.rawValue
        textField.errorChecker = { text in
            guard let value = Double(text) else { return true }
            return !(value >= option.optionName.minValue && value <= option.optionName.maxValue)
        }
        textField.delegate = self
        textField.keyboardType = .decimalPad
        unitLabel.text = option.optionName.metricValue
        self.updateAction = updateAction
    }
    
    func getModel() -> OptionModel? {
        guard let title = textField.labelTitle,
              let optionName = OptionDataName(rawValue: title),
              let model = model else {
            return nil
        }
        guard let value = Double(textField.getText() ?? "") else { return OptionModel(optionName: optionName, valueArray: [], dateArray: []) }
        if let lastValue = model.valueArray.last ?? nil, lastValue == value {
            return OptionModel(optionName: optionName, valueArray: model.valueArray, changedValue: model.changedValue, dateArray: model.dateArray, isShown: optionSwitch.isOn)
        } else {
            return OptionModel(optionName: optionName, valueArray: model.valueArray + [value], dateArray: model.dateArray + [Date().getSecondsSince1970()], isShown: optionSwitch.isOn)
        }
    }
    
    func getOption() -> OptionDataName? {
        guard let title = textField.labelTitle, let option = OptionDataName(rawValue: title) else { return nil }
        return option
    }
    
    func checkForError() -> Bool {
        textField.checkForError()
        return textField.getState() == .error
    }
}

extension OptionView: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        guard let newModel = getModel() else { return }
        updateAction?(newModel)
    }
}

private extension OptionView {
    func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.optionView, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        initialUISetup()
    }
    
    func initialUISetup() {
        unitLabel.font = .systemFont(ofSize: 18)
        unitLabel.textColor = .secondaryGray
        textField.placeholderText = ""
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        guard let newModel = getModel() else { return }
        updateAction?(newModel)
    }
}
