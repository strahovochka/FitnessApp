//
//  ActivityPopUpViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 15.08.2024.
//

import UIKit

protocol ActivityLevelDelegate: AnyObject {
    func didSelectActivityLevel(_ level: DailyCaloriesRateAtivity?)
}

final class ActivityPopUpViewController: UIViewController {
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var contentBackgroundView: UIView!
    @IBOutlet weak private var contentView: UIStackView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var optionsStack: UIStackView!
    @IBOutlet weak private var confirmButton: PlainButton!
    
    var viewModel: ActivityPopUpViewModel?
    weak var delegate: ActivityLevelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

private extension ActivityPopUpViewController {
    func configUI() {
        view.backgroundColor = .primaryBlack.withAlphaComponent(0.7)
        backgroundView.backgroundColor = .clear
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        
        contentBackgroundView.backgroundColor = .primaryBlack
        contentBackgroundView.layer.borderColor = UIColor.primaryWhite.cgColor
        contentBackgroundView.layer.borderWidth = 1
        contentBackgroundView.layer.cornerRadius = 8
        
        contentView.backgroundColor = .clear
        
        titleLabel.font = .mediumSaira?.withSize(18)
        titleLabel.textColor = .primaryYellow
        titleLabel.text = viewModel?.title
        
        configOptionsStack()
        
        confirmButton.setType(.filled)
        confirmButton.title = viewModel?.confirmButtonText
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    
    func configOptionsStack() {
        optionsStack.backgroundColor = .clear
        DailyCaloriesRateAtivity.allCases.forEach { level in
            let view = ActivityView()
            view.backgroundColor = .clear
            if let selectedLevel = viewModel?.selectedActivityLevel, selectedLevel == level {
                view.config(with: level, isSelected: true) { [weak self] level in
                    guard let self = self else { return }
                    self.updateOptionsStack(levelToDeselect: self.viewModel?.selectedActivityLevel)
                    self.viewModel?.setActivityLevel(level)
                }
            } else {
                view.config(with: level, isSelected: false) { [weak self] level in
                    guard let self = self else { return }
                    self.updateOptionsStack(levelToDeselect: self.viewModel?.selectedActivityLevel)
                    self.viewModel?.setActivityLevel(level)
                }
            }
            optionsStack.addArrangedSubview(view)
        }
    }
    
    func updateOptionsStack(levelToDeselect: DailyCaloriesRateAtivity?) {
        guard let levelToDeselect = levelToDeselect else { return }
        optionsStack.subviews.forEach { view in
            guard let view = view as? ActivityView, let level = view.activityLevel else { return }
            if level == levelToDeselect {
                view.deselect()
            }
        }
    }
    
    @objc func confirmButtonPressed() {
        delegate?.didSelectActivityLevel(viewModel?.selectedActivityLevel)
        hide()
    }
    
    @objc func hide() {
        self.dismiss(animated: true)
    }
}
