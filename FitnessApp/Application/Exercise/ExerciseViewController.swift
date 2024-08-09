//
//  ExerciseViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.08.2024.
//

import UIKit
import ReadMoreTextView

final class ExerciseViewController: BaseViewController {
    
    @IBOutlet weak private var exerciseImageView: UIImageView!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var exerciseNameLabel: UILabel!
    @IBOutlet weak private var characteristicsLabel: UILabel!
    @IBOutlet weak private var descriptionText: ReadMoreTextView!

    var viewModel: ExerciseViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        removeBackground()
        configUI()
        showNavigationBar(backButtonEnabled: true)
    }
}

private extension ExerciseViewController {
    func configUI() {
        self.title = viewModel?.navigationTitle
        self.view.backgroundColor = .primaryBlack
        exerciseImageView.contentMode = .scaleAspectFill
        exerciseImageView.addGradient([.clear, .primaryBlack.withAlphaComponent(0.6)], locations: [0.6, 1], type: .radial)
        
        exerciseNameLabel.font = .regularSaira?.withSize(18)
        exerciseNameLabel.textColor = .primaryWhite
        exerciseNameLabel.numberOfLines = 0
        
        characteristicsLabel.font = .lightNunito?.withSize(14)
        characteristicsLabel.textColor = .primaryYellow
        characteristicsLabel.numberOfLines = 0
        
        descriptionText.font = .lightSaira
        descriptionText.textColor = .secondaryGray
        descriptionText.backgroundColor = .clear
        descriptionText.shouldTrim = true
        descriptionText.maximumNumberOfLines = 4
        let attributedShowMoreString = NSAttributedString(string: viewModel?.showMoreText ?? "", attributes: [
            .font: UIFont.lightSaira ?? .systemFont(ofSize: 16),
            .foregroundColor: UIColor.primaryYellow
        ])
        descriptionText.attributedReadMoreText = attributedShowMoreString
        
        guard let exercise = viewModel?.exercise else { return }
        exerciseImageView.image = exercise.exerciseImage
        iconImageView.image = exercise.imageIcon
        exerciseNameLabel.text = exercise.name
        characteristicsLabel.text = exercise.getCharacteristics()
        descriptionText.text = exercise.descriptions
    }
}
