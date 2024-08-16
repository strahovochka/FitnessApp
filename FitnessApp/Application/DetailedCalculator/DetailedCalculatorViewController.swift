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
            self.configInputViews()
        }
        viewModel?.updateActivityLevel = { [weak self] in
            guard let self = self, let activityLevel = self.viewModel?.activityLevel else { return }
            self.activityLevelButton.setTitle(activityLevel.shortDescription, for: .normal)
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
        
        configInputViews()

        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .clear
        resultLabel.layer.cornerRadius = 8
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.primaryWhite.withAlphaComponent(0.4).cgColor
        configResultPlaceholder()
        
        resultDescriptionLabel.textColor = .primaryWhite
        resultDescriptionLabel.font = .lightSaira?.withSize(28)
        resultDescriptionLabel.textAlignment = .center
        
        configActivityButton()
        
        calculateButton.title = viewModel.calculateButtonText
        calculateButton.setType(.filled)
        calculateButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
    }
    
    func configSegmentedControl() {
        guard let viewModel = viewModel else { return }
        if viewModel.type != .BDM {
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
        resultDescriptionLabel.isHidden = true
    }

    func configInputViews() {
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
        guard viewModel.type == .dailyCalorieRequirement else { return }
    }
    
    func configActivityButton() {
        activityLevelButton.isHidden = false
        activityLevelButton.layer.masksToBounds = true
        activityLevelButton.backgroundColor = .clear
        activityLevelButton.layer.cornerRadius = activityLevelButton.frame.size.height / 2
        activityLevelButton.layer.borderWidth = 1
        activityLevelButton.layer.borderColor = UIColor.primaryWhite.cgColor
        activityLevelButton.setTitle(viewModel?.activityButtonText, for: .normal)
        activityLevelButton.setTitleColor(.primaryWhite, for: .normal)
        activityLevelButton.titleLabel?.font = .regularSaira
        activityLevelButton.addTarget(self, action: #selector(activityButtonPressed), for: .touchUpInside)
    }
    
    func didTapOnSegment(_ index: Int) {
        guard let viewModel = viewModel else { return }
        viewModel.selectedSegmentSex = viewModel.segmentItems[index]
    }
    
    @objc func calculate() {
        inputsStackCiew.subviews.forEach { view in
            guard let view = view as? CalculatorInputView else { return }
            view.checkForError()
        }
        if inputsStackCiew.subviews.compactMap({ $0 as? CalculatorInputView}).contains(where: { $0.isError() }) {
            
        }
    }
    
    @objc func activityButtonPressed() {
        viewModel?.goToActivityPopUp()
    }
}
