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
        if let lastElement = option.valueArray.last, let value = lastElement {
            textField.text = String(value)
        } else {
            textField.text = ""
        }
        textField.labelTitle = option.optionName.rawValue
        textField.errorChecker = { text in
            guard let value = Double(text) else { return true }
            return !(value >= option.optionName.minValue && value <= option.optionName.maxValue)
        }
        textField.setTextFieldDelegate(self)
        textField.delegate = self
        unitLabel.text = option.optionName.metricValue
        optionSwitch.isOn = option.isShown ?? true
        self.updateAction = updateAction
    }
    
    func getModel() -> OptionModel? {
        if let title = textField.labelTitle,
           let optionName = OptionDataName(rawValue: title),
           let model = model {
            if let currentValue = Double(textField.getText() ?? "") { //current value exists
                if let lastElement = model.valueArray.last { // array is not empty
                    if let lastValue = lastElement { //old value not nil case -> check if equal
                        if lastValue != currentValue { // values are not equal -> return updated arrays
                            return OptionModel(optionName: optionName, valueArray: model.valueArray + [currentValue], changedValue: lastValue - currentValue, dateArray: model.dateArray + [Int(Date().timeIntervalSince1970)], isShown: optionSwitch.isOn)
                        } else { // values are equal -> return old arrays
                            return OptionModel(optionName: optionName, valueArray: model.valueArray, changedValue: model.changedValue, dateArray: model.dateArray, isShown: optionSwitch.isOn)
                        }
                    } else { //old value is nil case
                        return OptionModel(optionName: optionName, valueArray: model.valueArray + [currentValue], changedValue: nil, dateArray: model.dateArray + [Int(Date().timeIntervalSince1970)], isShown: optionSwitch.isOn)
                    }
                } else { //array is empty
                    return OptionModel(optionName: optionName, valueArray: [currentValue], changedValue: nil, dateArray: [Int(Date().timeIntervalSince1970)], isShown: optionSwitch.isOn)
                }
            } else { //empty field
                return OptionModel(optionName: optionName, valueArray: [], dateArray: [])
            }
        }
        return nil
    }
    
    func getOption() -> OptionDataName? {
        if let title = textField.labelTitle, let option = OptionDataName(rawValue: title) {
            return option
        }
        return nil
    }
    
    func checkForError() -> Bool {
        textField.checkForError()
        return textField.getState() == .error
    }
}

extension OptionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension OptionView: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        if let newModel = getModel() {
            updateAction?(newModel)
        }
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
        if let newModel = getModel() {
            updateAction?(newModel)
        }
    }
}
