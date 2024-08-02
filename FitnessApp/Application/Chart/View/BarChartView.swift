//
//  BarChartView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 02.08.2024.
//

import UIKit

final class BarChartView: UIView {
    private let barWidth: CGFloat = 58.0
    private let barSpace: CGFloat = 12.0
    private let bottomSpace: CGFloat = 29.0
    private let valueHeight: CGFloat = 25.0
    private let progressHeight: CGFloat = 25.0
    private let elementsSpace: CGFloat = 4.0
    private let scrollView = UIScrollView()
    private let mainLayer = CALayer()
    
    var records: [Record]? = nil {
        didSet {
            mainLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
            guard let records = records else { return }
            scrollView.contentSize = CGSize(width: (barWidth + barSpace)*CGFloat(records.count), height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            for (index, record) in records.enumerated() {
                drawRecord(index: index, record: record)
            }
            drawHorizontalLine(y: mainLayer.frame.height - bottomSpace)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    func configUI() {
        self.backgroundColor = .clear
        scrollView.layer.addSublayer(mainLayer)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
}

private extension BarChartView {
    
    func drawRecord(index: Int, record: Record) {
        let x = barSpace + (barWidth + barSpace)*CGFloat(index)
        let y = (1 - record.barHeightCoeff)*(mainLayer.frame.height - bottomSpace) + record.barHeightCoeff*(valueHeight + progressHeight + 2*elementsSpace)
        let dateTextY = mainLayer.frame.height - bottomSpace + 4
        let valueTextY = y - valueHeight - elementsSpace
        let progressTextY = valueTextY - progressHeight - elementsSpace
        
        if index == 0 {
            drawHorizontalLine(y: y, isDashed: true)
        }
        drawDate(x: x, y: dateTextY, date: record.date)
        drawBar(x: x, y: y, color: record.barColor) { [weak self] in
            guard let self = self else { return }
            self.drawValue(x: x, y: valueTextY, value: "\(record.value.roundedString(to: 0)) \(record.units)")
            guard let progress = record.progress, progress != 0 else { return }
            self.drawProgress(x: x, y: progressTextY, progress: "\(progress > 0 ? "+" : "") \(progress.roundedString(to: 0))", color: progress > 0 ? .primaryOrange : .greenColor)
        }
    }
    
    func drawBar(x: CGFloat, y: CGFloat, color: CGColor, completion: @escaping () -> ()) {
        let bar = CALayer()
        bar.backgroundColor = UIColor.clear.cgColor
        bar.cornerRadius = 20
        bar.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bar.anchorPoint = CGPoint(x: 1, y: 1)
        bar.frame = CGRect(x: x, y: y, width: barWidth, height: mainLayer.frame.height - y - bottomSpace)
        mainLayer.addSublayer(bar)
        
        var animations = [CABasicAnimation]()
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.duration = 1.0
        colorAnimation.fromValue = bar.backgroundColor
        colorAnimation.toValue = color
        animations.append(colorAnimation)
        
        let heightAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        heightAnimation.duration = 1.0
        heightAnimation.fromValue = 0
        heightAnimation.toValue = bar.bounds.size.height
        heightAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animations.append(heightAnimation)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.0
        animationGroup.animations = animations
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        CATransaction.setCompletionBlock {
            completion()
        }
        bar.add(animationGroup, forKey: nil)
        CATransaction.commit()
        bar.backgroundColor = color
    }
    
    func drawDate(x: CGFloat, y: CGFloat, date: Date) {
        let dateLayer = drawTextLayer(x: x, y: y, width: barWidth, height: bottomSpace - elementsSpace, font: .regularSaira)
        dateLayer.string = date.formatDate("dd.MM")
        mainLayer.addSublayer(dateLayer)
    }
    
    func drawValue(x: CGFloat, y: CGFloat, value: String) {
        let valueLayer = drawTextLayer(x: x, y: y, width: barWidth, height: valueHeight, font: .regularSaira)
        valueLayer.string = value
        mainLayer.addSublayer(valueLayer)
        valueLayer.fadeIn()
    }
    
    func drawProgress(x: CGFloat, y: CGFloat, progress: String, color: UIColor) {
        let progressLayer = drawTextLayer(x: x, y: y, width: barWidth, height: progressHeight, font: .regularGilroy)
        progressLayer.string = progress
        progressLayer.backgroundColor = color.cgColor
        progressLayer.cornerRadius = progressHeight / 2
        mainLayer.addSublayer(progressLayer)
        progressLayer.fadeIn()
    }
    
    func drawHorizontalLine(y: CGFloat, isDashed: Bool = false) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.primaryWhite.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineDashPattern = isDashed ? [4, 4] : nil

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: y))
        path.addLine(to: CGPoint(x: frame.width, y: y))
        shapeLayer.path = path

        layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func drawTextLayer(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, font: UIFont?) -> CATextLayer {
        let layer = CenteredCATextLayer()
        layer.contentsScale = 2.0
        layer.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = UIColor.primaryWhite.cgColor
        layer.font = font
        layer.fontSize = 16
        layer.alignmentMode = .center
        return layer
    }
}
