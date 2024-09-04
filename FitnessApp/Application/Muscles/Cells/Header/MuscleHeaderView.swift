//
//  MuscleHeaderView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.08.2024.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func toggleSection(header: MuscleHeaderView, section: Int)
}

class MuscleHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak private var expandArrowImageView: UIImageView!
    @IBOutlet weak private var muscleNameLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    var isCollapsed: Bool = true
    weak var delegate: HeaderViewDelegate?
    
    var muscle: MuscleExercisesModel? {
        didSet {
            muscleNameLabel.text = muscle?.muscleName
            setCollapsed(muscle?.isCollapsed ?? true)
            setCounterValue(muscle?.count ?? 0)
        }
    }
    var section: Int = 0
    
    override func awakeFromNib() {
       super.awakeFromNib()
        configUI()
    }
    
    func setCollapsed(_ collapsed: Bool) {
        expandArrowImageView.transform = CGAffineTransform(rotationAngle: collapsed ? 0.0 : .pi)
    }
    
}

private extension MuscleHeaderView {
    func configUI() {
        backgroundConfiguration = UIBackgroundConfiguration.clear()
        muscleNameLabel.font = .systemFont(ofSize: 18)
        muscleNameLabel.textColor = .primaryWhite
        
        counterLabel.font = .systemFont(ofSize: 18)
        counterLabel.textColor = .primaryWhite
        
        expandArrowImageView.image = .expandArrow
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
        addSeparator()
    }
    
    func addSeparator() {
        let y = self.layer.frame.maxY
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.muscleNameLabel.frame.minX, y: y))
        path.addLine(to: CGPoint(x: self.frame.maxX, y: y))
        let separatorLayer = CAShapeLayer()
        separatorLayer.path = path.cgPath
        separatorLayer.lineWidth = 1
        separatorLayer.strokeColor = UIColor.primaryWhite.cgColor
        self.layer.addSublayer(separatorLayer)
    }
    
    @objc func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCounterValue(_ value: Int) {
        counterLabel.isHidden = !(value > 0)
        counterLabel.text = "\(value)"
    }
}
