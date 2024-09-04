//
//  ActivityView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 15.08.2024.
//

import UIKit

final class ActivityView: UIView {
    
    @IBOutlet weak private var radioButton: CustomImageButton!
    @IBOutlet weak private var activityNameLabel: UILabel!
    private(set) var activityLevel: DailyCaloriesRateAtivity?
    
    private var tapAction: ((DailyCaloriesRateAtivity) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    func config(with level: DailyCaloriesRateAtivity, isSelected: Bool, tapAction: ((DailyCaloriesRateAtivity) -> ())?) {
        activityNameLabel.text = level.rawValue
        self.tapAction = tapAction
        activityLevel = level
        guard isSelected else { return }
        radioButton.buttonTapped(radioButton)
    }
    
    func deselect() {
        radioButton.deselect()
    }
}

private extension ActivityView {
    func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.activityView, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        initialUISetup()
    }
    
    func initialUISetup() {
        self.backgroundColor = .clear
        radioButton.setImaged(filled: .radioFilled, unfilled: .radioUnfilled)
        activityNameLabel.font = .systemFont(ofSize: 16)
        activityNameLabel.textColor = .primaryWhite
        activityNameLabel.numberOfLines = 0
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    @objc func didTap() {
        guard !radioButton.tapped else { return }
        guard let activityLevel = DailyCaloriesRateAtivity(rawValue: activityNameLabel.text ?? "") else { return }
        radioButton.buttonTapped(radioButton)
        tapAction?(activityLevel)
    }
}
