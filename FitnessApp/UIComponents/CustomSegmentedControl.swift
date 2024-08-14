//
//  CustomSegmentControl.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import UIKit

final class CustomSegmentedControl: UIView {
    
    private var stackView = UIStackView()
    private var buttons: [UIButton] = []
    private var currentIndexView = UIView()
    private var currentIndex: Int = 0 {
        didSet {
            setSelectedIndexView()
        }
    }
    
    var didTapSegment: ((Int) -> ())?
    var items: [String] = ["Item 1", "Item 2"] {
        didSet {
            if !items.isEmpty {
                addSegments()
                currentIndex = 0
            }
        }
    }
    
    var selectedColor: UIColor = .primaryYellow {
        didSet {
            setSelectedIndexBackground()
        }
    }
    
    var selectedTitleColor: UIColor = .primaryBlack {
        didSet {
            updateTextColors()
        }
    }
    
    var unselectedTitleColor: UIColor = .primaryYellow {
        didSet {
            updateTextColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetUp()
    }
}

private extension CustomSegmentedControl {
    func initialSetUp() {
        self.backgroundColor = .clear
        configStackView()
        addSegments()
        setBorder()
        configSelectedIndexView()
    }
    
    func configStackView() {
        stackView.backgroundColor = .clear
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func addSegments() {
        clearSegments()
        for (index, item) in items.enumerated() {
            let button = UIButton()
            button.layer.masksToBounds = true
            button.setTitle(item, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.tag = index
            button.addTarget(self, action: #selector(segmentTaped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        updateTextColors()
    }
    
    func clearSegments() {
        buttons.removeAll()
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func updateTextColors() {
        stackView.subviews.enumerated().forEach { (index, view) in
            guard let button = view as? UIButton else { return }
            button.setTitleColor((index == currentIndex ? .primaryBlack : .primaryYellow), for: .normal)
        }
    }
    
    func configSelectedIndexView() {
        setSelectedIndexBackground()
        addSubview(currentIndexView)
        sendSubviewToBack(currentIndexView)
    }
    
    func setSelectedIndexBackground() {
        currentIndexView.backgroundColor = selectedColor
    }
    
    func setBorder() {
        self.layoutIfNeeded()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = selectedColor.cgColor
        self.layer.masksToBounds = true
    }
    
    func setSelectedIndexView() {
        self.layoutIfNeeded()
        stackView.subviews.enumerated().forEach { (index, view) in
            guard let button = view as? UIButton else { return }
            if index == currentIndex {
                let buttonWidth = frame.width / CGFloat(buttons.count)
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let self = self else { return }
                    self.currentIndexView.frame = CGRectMake(buttonWidth * CGFloat(index), 0, buttonWidth, self.frame.height)
                }
                button.setTitleColor(selectedTitleColor, for: .normal)
            } else {
                button.setTitleColor(unselectedTitleColor, for: .normal)
            }
        }
    }
    
    @objc func segmentTaped(_ sender: UIButton) {
        didTapSegment?(sender.tag)
        currentIndex = sender.tag
    }
}


