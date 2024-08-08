//
//  MuscleHeaderView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.08.2024.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func toggleSection(header: MuscleHeaderView, section: Int)
    func didSelectExercise(from muscle: String, _ name: String, selected: Bool)
}

class MuscleHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak private var expandArrowImageView: UIImageView!
    @IBOutlet weak private var muscleNameLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    var isCollapsed: Bool = true
    var delegate: HeaderViewDelegate?
    
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
        if value > 0 {
            counterLabel.isHidden = false
            counterLabel.text = "\(value)"
        } else {
            counterLabel.isHidden = true
        }
    }
}

extension MuscleHeaderView: ExerciseCellDelegate {
    func didSelectExercise(_ name: String, selected: Bool) {
        guard let muscleName = muscle?.muscleName else { return }
        delegate?.didSelectExercise(from: muscleName, name, selected: selected)
    }
}
