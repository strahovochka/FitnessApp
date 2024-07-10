//
//  TextFieldTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak private var textFieldView: CustomTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(title: String, placeholder: String, errorAction: ((String) -> (Bool))? = nil) {
        self.textFieldView.labelTitle = title
        self.textFieldView.placeholderText = placeholder
        self.textFieldView.errorChecker = errorAction
    }
    
    func getText() -> String? {
        textFieldView.getText()
    }
    
}
