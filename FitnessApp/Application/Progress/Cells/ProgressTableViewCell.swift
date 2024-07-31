//
//  ProgressTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.07.2024.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var optionTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        optionTitleLabel.font = .systemFont(ofSize: 18)
        optionTitleLabel.textColor = .primaryWhite
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(with name: String) {
        optionTitleLabel.text = name
    }
    
}
