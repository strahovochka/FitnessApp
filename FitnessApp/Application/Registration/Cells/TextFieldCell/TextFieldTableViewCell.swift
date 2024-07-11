//
//  TextFieldTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak private var textFieldView: CustomTextField!
    private var cellType: RegistrationViewModel.CellType?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(cellType: RegistrationViewModel.CellType, delegate: TextFieldRegistrationDelegate?) {
        self.textFieldView.labelTitle = cellType.title
        self.textFieldView.placeholderText = cellType.placeholderText
        self.textFieldView.errorChecker = cellType.errorChecker
        self.textFieldView.delegate = delegate
        self.textFieldView.setCellType(cellType)
    }
    
    func setErrorChecker(_ checker: @escaping (String) -> (Bool)) {
        self.textFieldView.errorChecker = checker
    }
    
    func isError() -> Bool {
        textFieldView.isError()
    }
    
}
