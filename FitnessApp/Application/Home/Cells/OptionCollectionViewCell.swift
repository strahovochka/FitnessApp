//
//  OptionCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 26.07.2024.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var optionNameLabel: UILabel!
    @IBOutlet weak private var optionValueLabel: UILabel!
    @IBOutlet weak private var progressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialUISetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressLabel.isHidden = true
    }

    func config(with option: OptionModel) {
        optionNameLabel.text = option.optionName.rawValue
        let boldAttributed: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold),
            .foregroundColor: UIColor.primaryYellow
        ]
        let plainAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.primaryWhite
        ]
        var valueAttributedString: NSMutableAttributedString = .init()
        if let last = option.valueArray.last, let value = last {
            valueAttributedString = NSMutableAttributedString(string: "\(value.roundedString(to: 0)) ", attributes: boldAttributed)
        }
        valueAttributedString.append(NSAttributedString(string: option.optionName.metricValue, attributes: plainAttributes))
        optionValueLabel.attributedText = valueAttributedString
        if let changedValue = option.changedValue {
            progressLabel.isHidden = false
            progressLabel.text = changedValue > 0 ? "+\(changedValue.roundedString())" : "\(changedValue.roundedString())"
            progressLabel.font = .regularGilroy?.withSize(changedValue.truncatingRemainder(dividingBy: 1) == 0 ? 19 : 16)
            progressLabel.layer.cornerRadius = progressLabel.bounds.height / 2
            progressLabel.layer.masksToBounds = true
            progressLabel.backgroundColor = changedValue > 0 ? .redColor : .greenColor
        }
    }
}

private extension OptionCollectionViewCell {
    func initialUISetup() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.primaryWhite.cgColor
        optionNameLabel.font = .systemFont(ofSize: 20)
        optionNameLabel.textColor = .primaryWhite
        optionValueLabel.font = .systemFont(ofSize: 20)
        optionValueLabel.textColor = .primaryWhite
        progressLabel.isHidden = true
        progressLabel.textColor = .primaryWhite
    }
}
