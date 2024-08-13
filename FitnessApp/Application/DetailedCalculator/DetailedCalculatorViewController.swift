//
//  DetailedCalculatorViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import UIKit

final class DetailedCalculatorViewController: BaseViewController {
    
    @IBOutlet weak private var calculatorNameLabel: UILabel!
    @IBOutlet weak private var inputsStackCiew: UIStackView!
    @IBOutlet weak private var resultLabel: UILabel!
    @IBOutlet weak private var resultDescriptionLabel: UILabel!
    @IBOutlet weak private var calculateButton: PlainButton!
    
    var viewModel: DetailedCalculatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        showNavigationBar(backButtonEnabled: true)
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
        
        viewModel.inputs.forEach { input in
            let inputView = CalculatorInputView()
            inputView.config(with: input)
            inputView.translatesAutoresizingMaskIntoConstraints = false
            inputView.heightAnchor.constraint(equalToConstant: 42).isActive = true
            inputsStackCiew.addArrangedSubview(inputView)
        }

        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .clear
        resultLabel.layer.cornerRadius = 8
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.primaryWhite.withAlphaComponent(0.4).cgColor
        configResultPlaceholder()
        
        resultDescriptionLabel.textColor = .primaryWhite
        resultDescriptionLabel.font = .lightSaira?.withSize(28)
        resultDescriptionLabel.textAlignment = .center
        
        calculateButton.title = viewModel.calculateButtonText
        calculateButton.setType(.filled)
    }
    
    func configResultPlaceholder() {
        resultLabel.textColor = .secondaryGray
        resultLabel.font = .lightSaira?.withSize(18)
        resultLabel.text = viewModel?.resultPlaceholderText
        resultDescriptionLabel.isHidden = true
    }
}
