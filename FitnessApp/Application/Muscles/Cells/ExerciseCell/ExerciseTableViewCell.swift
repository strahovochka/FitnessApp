//
//  ExerciseTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.08.2024.
//

import UIKit

protocol ExerciseCellDelegate: AnyObject {
    func didSelectExercise(selected: Bool, cell: ExerciseTableViewCell)
}

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var exerciseImageView: UIImageView!
    @IBOutlet weak private var exerciseNameLabel: UILabel!
    @IBOutlet weak private var characteristictsLabel: UILabel!
    @IBOutlet weak private var moreAboutButton: PlainButton!
    @IBOutlet weak private var selectedImageView: UIImageView!
    weak var delegate: ExerciseCellDelegate?
    var exercise: ExerciseModel? {
        didSet {
            configWithExercise()
            configSelectedState(for: exercise?.isSelected ?? false)
        }
    }
    var moreAboutAction: ((_ cell: ExerciseTableViewCell) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

private extension ExerciseTableViewCell {
    func configUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        containerView.backgroundColor = .clear
        containerView.layer.borderColor = UIColor.secondaryGray.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        exerciseNameLabel.font = .regularSaira?.withSize(18)
        exerciseNameLabel.textColor = .primaryWhite
        exerciseNameLabel.numberOfLines = 0
        
        characteristictsLabel.font = .lightNunito?.withSize(14)
        characteristictsLabel.textColor = .primaryYellow
        characteristictsLabel.numberOfLines = 0
        characteristictsLabel.lineBreakStrategy = .hangulWordPriority
        
        moreAboutButton.title = "More about"
        moreAboutButton.setFont(.lightNunito?.withSize(16))
        moreAboutButton.imageView?.image = .rightArrow
        moreAboutButton.configuration?.contentInsets = .zero
        moreAboutButton.addTarget(self, action: #selector(moreAboutButtonPressed), for: .touchUpInside)
        
        selectedImageView.image = .selectedFilled
        selectedImageView.isHidden = true
    }
    
    func configWithExercise() {
        guard let exercise = exercise else { return }
        if let exerciseIcon = exercise.imageIcon {
            exerciseImageView.image = exerciseIcon
        } else {
            exerciseImageView.image = .exerciseIcon
        }
        exerciseNameLabel.text = exercise.name
        characteristictsLabel.text = exercise.getCharacteristics()
    }
    
    func configSelectedState(for isSelected: Bool) {
        selectedImageView.isHidden = !isSelected
        if isSelected {
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor.primaryYellow.cgColor
        } else {
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.secondaryGray.cgColor
        }
    }
    
    @objc func didTap() {
        guard let _ = exercise else { return }
        self.exercise?.isSelected.toggle()
        delegate?.didSelectExercise(selected: self.exercise?.isSelected ?? false, cell: self)
    }
    
    @objc func moreAboutButtonPressed() {
        moreAboutAction?(self)
    }
}
