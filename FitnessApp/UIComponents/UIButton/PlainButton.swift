//
//  ParentPlainButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

class PlainButton: UIButton {
    
    enum ViewType {
        case filled
        case unfilled
        case alert
    }
    
    private var type: PlainButton.ViewType? {
        didSet {
            configUI()
        }
    }
    
    var title: String? = "" {
        didSet {
            titleLabel?.text = title
            configUI()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            self.configuration?.baseBackgroundColor = isEnabled ? .primaryYellow : UIColor(hex: "#E1E1E1")
            self.alpha = 1.0
        }
    }
    
    init(type: PlainButton.ViewType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configUI()
    }
    
    func configUI() {
        self.titleLabel?.textAlignment = .center
        switch self.type {
        case .filled:
            var buttonConfig = UIButton.Configuration.filled()
            buttonConfig.cornerStyle = .capsule
            buttonConfig.baseBackgroundColor = .primaryYellow
            buttonConfig.baseForegroundColor = .primaryBlack
            self.configuration = buttonConfig
            self.setFont(.regularSaira)
        case .unfilled:
            var buttonConfig = UIButton.Configuration.plain()
            buttonConfig.baseForegroundColor = .primaryYellow
            self.configuration = buttonConfig
            self.setFont(.mediumSaira)
        case .alert:
            var buttonConfig = UIButton.Configuration.plain()
            buttonConfig.baseForegroundColor = .primaryOrange
            self.configuration = buttonConfig
            self.setFont(.mediumSaira)
        case .none:
            break
        }
    }
    
    func setType(_ type: PlainButton.ViewType) {
        self.type = type
    }
    
    func setFont(_ font: UIFont?) {
        if let title = self.titleLabel, let text = title.text {
            let attributedTitle: NSAttributedString = NSAttributedString(string: text, attributes: [.font: font ?? .systemFont(ofSize: 16)])
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}
