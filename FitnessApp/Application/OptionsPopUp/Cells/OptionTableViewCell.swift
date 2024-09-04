//
//  OptionTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak private var checkBoxButton: CustomImageButton!
    @IBOutlet weak private var optionNameLabel: UILabel!
    
    var checkButtonPressedAction: ((OptionDataName, Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(with option: OptionDataName, isSelected: Bool, tapAction: ((OptionDataName, Bool) -> ())?) {
        checkBoxButton.setImaged(filled: .checkboxFilled, unfilled: .checkboxUnfilled)
        optionNameLabel.font = .regularSaira?.withSize(18)
        optionNameLabel.textColor = .primaryWhite
        optionNameLabel.text = option.rawValue
        checkButtonPressedAction = tapAction
        if isSelected {
            self.checkBoxButton.buttonTapped(checkBoxButton)
        }
    }
    
    func toggle() {
        checkButtonPressed(self)
        checkBoxButton.buttonTapped(checkBoxButton)
    }
    
    func isSelected() -> Bool {
        checkBoxButton.tapped
    }
    
    
    @IBAction private func checkButtonPressed(_ sender: Any) {
        if let option = OptionDataName(rawValue: optionNameLabel.text ?? "") {
            checkButtonPressedAction?(option, !checkBoxButton.tapped)
        }
    }
    
}
