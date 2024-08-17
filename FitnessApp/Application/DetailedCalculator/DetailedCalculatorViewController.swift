//
//  DetailedCalculatorViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import UIKit

final class DetailedCalculatorViewController: BaseViewController {
    
    @IBOutlet weak private var calculatorNameLabel: UILabel!
    @IBOutlet weak private var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak private var inputsStackCiew: UIStackView!
    @IBOutlet weak private var resultLabel: UILabel!
    @IBOutlet weak private var resultDescriptionLabel: UILabel!
    @IBOutlet weak private var calculateButton: PlainButton!
    @IBOutlet weak private var activityLevelButton: UIButton!
    
    var viewModel: DetailedCalculatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        showNavigationBar(backButtonEnabled: true)
        viewModel?.update = { [weak self] in
            guard let self = self else { return }
            self.updateInputs()
            self.updateResult()
        }
        viewModel?.updateActivityLevel = { [weak self] activityLevel in
            guard let self = self, let activityLevel = activityLevel else { return }
            self.updateActivityButton(with: activityLevel)
        }
        viewModel?.updateResult = { [weak self] in
            guard let self = self else { return }
            self.updateResult()
        }
    }
}

private extension DetailedCalculatorViewController {
    func configUI() {
        guard let viewModel = viewModel else { return }
        setBackground(for: viewModel.sex)
        self.title = viewModel.navigationTitle
        
        calculatorNameLabel.textColor = .primaryWhite
        calculatorNameLabel.font = .mediumSaira?.withSize(24)
        calculatorNameLabel.text = viewModel.type.name
        
        configSegmentedControl()
        updateInputs()

        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .clear
        resultLabel.layer.cornerRadius = 8
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.primaryWhite.withAlphaComponent(0.4).cgColor
        configResultPlaceholder()
        
        resultDescriptionLabel.textColor = .primaryWhite
        resultDescriptionLabel.font = .lightSaira?.withSize(18)
        resultDescriptionLabel.textAlignment = .center
        
        if viewModel.type == .dailyCalorieRequirement {
            configActivityButton()
        }
        
        calculateButton.title = viewModel.calculateButtonText
        calculateButton.setType(.filled)
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
    }
    
    func configSegmentedControl() {
        guard let viewModel = viewModel else { return }
        if viewModel.type != .BMI {
            segmentedControl.isHidden = false
            segmentedControl.items = viewModel.segmentItems.map{ $0.heroName }
            segmentedControl.didTapSegment = { [weak self] index in
                guard let self = self else { return }
                self.didTapOnSegment(index)
            }
        } else {
            segmentedControl.isHidden = true
        }
    }
    
    func configResultPlaceholder() {
        resultLabel.textColor = .secondaryGray
        resultLabel.font = .lightSaira?.withSize(18)
        resultLabel.text = viewModel?.resultPlaceholderText
        guard let viewModel = viewModel, viewModel.type == .dailyCalorieRequirement else {
            resultDescriptionLabel.isHidden = true
            return
        }
        resultDescriptionLabel.isHidden = false
        resultDescriptionLabel.text = viewModel.caloriesDescriptionText
    }
    
    func configActivityButton() {
        activityLevelButton.isHidden = false
        activityLevelButton.layer.masksToBounds = true
        activityLevelButton.backgroundColor = .clear
        activityLevelButton.layer.cornerRadius = activityLevelButton.frame.size.height / 2
        activityLevelButton.layer.borderWidth = 1
        activityLevelButton.layer.borderColor = UIColor.primaryWhite.cgColor
        activityLevelButton.setTitleColor(.primaryWhite, for: .normal)
        activityLevelButton.titleLabel?.font = .regularSaira
        activityLevelButton.addTarget(self, action: #selector(activityButtonPressed), for: .touchUpInside)
        activityLevelButton.setTitle(viewModel?.activityButtonText, for: .normal)
    }
    
    func configActivityErrorState() {
        activityLevelButton.layer.borderColor = UIColor.primaryRed.cgColor
        activityLevelButton.titleLabel?.textColor = .primaryRed
    }
    
    func configInputError() {
        resultLabel.layer.borderColor = UIColor.primaryRed.cgColor
        resultLabel.textColor = .primaryRed
        resultLabel.font = .regularSaira
        resultLabel.text = BMILevel.empty.rawValue
    }
    
    //MARK: -Updaters
    
    func updateInputs() {
        guard let viewModel = viewModel else { return }
        inputsStackCiew.subviews.forEach { $0.removeFromSuperview() }
        let selectedInputs = viewModel.getSelectedInputs()
        selectedInputs.forEach { (input, value) in
            let view = input.createView()
            view.config(with: input, value: value, delegate: viewModel)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 42).isActive = true
            inputsStackCiew.addArrangedSubview(view)
        }
    }
    
    func updateActivityButton(with activityLevel: DailyCaloriesRateAtivity? = nil) {
        activityLevelButton.layer.borderColor = UIColor.primaryWhite.cgColor
        activityLevelButton.titleLabel?.textColor = .primaryWhite
        guard let activityLevel = activityLevel, activityLevel != .empty else {
            activityLevelButton.setTitle(viewModel?.activityButtonText, for: .normal)
            return
        }
        activityLevelButton.setTitle(activityLevel.shortDescription, for: .normal)
    }

    func updateResult() {
        guard let viewModel = viewModel else { return }
        resultLabel.layer.borderColor = UIColor.primaryWhite.withAlphaComponent(0.4).cgColor
        if viewModel.type != .dailyCalorieRequirement {
            if let level = viewModel.result?.level {
                resultDescriptionLabel.isHidden = level.isEmpty
                resultDescriptionLabel.text = level.description
            }
        }
        
        guard let result = viewModel.result?.value else {
            configResultPlaceholder()
            return
        }
        resultLabel.font = .boldSaira?.withSize(24)
        resultLabel.textColor = .primaryYellow
        resultLabel.text = result.roundedString(to: 2)
    }
    
    func didTapOnSegment(_ index: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.updateSelectedSegment(with: viewModel.segmentItems[index])
    }
    
    //MARK: -Actions
    
    @objc func calculate() {
        guard let viewModel = viewModel else { return }
        inputsStackCiew.subviews.forEach { view in
            guard let view = view as? CalculatorInputView else { return }
            view.checkForError()
        }
        var allowCalculation = true
        if inputsStackCiew.subviews.compactMap({ $0 as? CalculatorInputView}).contains(where: { $0.isError() }) {
            allowCalculation = false
        }
        if viewModel.type == .dailyCalorieRequirement && viewModel.activityLevel == .empty {
            allowCalculation = false
            configActivityErrorState()
        }
        if allowCalculation {
            viewModel.calculateResult()
        } else {
            configInputError()
        }
    }
    
    @objc func activityButtonPressed() {
        viewModel?.goToActivityPopUp()
        activityLevelButton.setTitleColor(.primaryWhite, for: .normal)
        activityLevelButton.layer.borderColor = UIColor.primaryWhite.cgColor
    }
}
