//
//  ExerciseTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.08.2024.
//

import UIKit

protocol ExerciseCellDelegate {
    func didSelectExercise(_ name: String, selected: Bool, cell: ExerciseTableViewCell)
}

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var exerciseImageView: UIImageView!
    @IBOutlet weak private var exerciseNameLabel: UILabel!
    @IBOutlet weak private var characteristictsLabel: UILabel!
    @IBOutlet weak private var moreAboutButton: PlainButton!
    @IBOutlet weak private var selectedImageView: UIImageView!
    var delegate: ExerciseCellDelegate?
    var exercise: ExerciseModel? {
        didSet {
            configWithExercise()
            configSelectedState(for: exercise?.isSelected ?? false)
        }
    }
    
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
        
        selectedImageView.image = .selectedFilled
        selectedImageView.isHidden = true
    }
    
    func configWithExercise() {
        guard let exercise = exercise else { return }
        exerciseImageView.image = UIImage(named: exercise.imageIcon)
        exerciseNameLabel.text = exercise.name
        characteristictsLabel.text = [exercise.equipment.rawValue, exercise.level.rawValue, exercise.exerciseType.rawValue].joined(separator: ", ")
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
        guard let exercise = exercise else { return }
        self.exercise?.isSelected.toggle()
        delegate?.didSelectExercise(exercise.name, selected: self.exercise?.isSelected ?? false, cell: self)
    }
}
