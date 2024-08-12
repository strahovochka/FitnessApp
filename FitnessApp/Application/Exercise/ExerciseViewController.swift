//
//  ExerciseViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.08.2024.
//

import UIKit

final class ExerciseViewController: BaseViewController {
    
    @IBOutlet weak private var exerciseImageView: UIImageView!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var exerciseNameLabel: UILabel!
    @IBOutlet weak private var characteristicsLabel: UILabel!
    @IBOutlet weak private var descriptionText: UILabel!
    
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
        
        guard let exercise = viewModel?.exercise else { return }
        exerciseImageView.image = exercise.exerciseImage
        iconImageView.image = exercise.imageIcon
        exerciseNameLabel.text = exercise.name
        characteristicsLabel.text = exercise.getCharacteristics()
        addExpandableText()
    }
    
    func addExpandableText() {
        descriptionText.numberOfLines = 4
        descriptionText.isUserInteractionEnabled = true
        descriptionText.font = .lightSaira
        descriptionText.textColor = .secondaryGray
        self.view.layoutIfNeeded()
        
        guard let exercise = viewModel?.exercise else { return }
        descriptionText.addExpandingText(viewModel?.showMoreText ?? "", after: exercise.descriptions)
        descriptionText.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMorePressed(_:))))
    }
    
    @objc func showMorePressed(_ gesture: UITapGestureRecognizer) {
        guard let text = descriptionText.text, let viewModel = viewModel else { return }
        let targetRange = (text as NSString).range(of: viewModel.showMoreText)
        if gesture.didTap(label: descriptionText, inRange: targetRange) {
            descriptionText.expand(with: viewModel.exercise.descriptions)
        }
    }
}
