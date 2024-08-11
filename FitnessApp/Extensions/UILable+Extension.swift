//
//  UILable+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 11.08.2024.
//

import UIKit

extension UILabel {
    var maximumNumberOfLines: Int { return self.numberOfLines }
    var highlight: UIColor? { return .primaryYellow }
    
    
    private func height(for text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = maximumNumberOfLines
        label.lineBreakMode = .byTruncatingTail
        label.font = self.font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    private func highlight(text: String) {
        guard let labelText = self.text else { return }
        let range = (labelText as NSString).range(of: text)
        
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.addAttributes([.foregroundColor: highlight ?? .primaryYellow], range: range)
        self.attributedText = attributedText
    }
    
    func addExpandingText(_ expandingText: String, after text: String) {
        self.numberOfLines = maximumNumberOfLines
        let linesText = String(Array(repeating: "\n", count: maximumNumberOfLines - 1))
        let requiredHeightForText = height(for: linesText)
        let nsText = NSString(string: text)
        let range = NSRange(location: 0, length: nsText.length)
        var cutText = nsText
        var lastIndex = range.upperBound
        let size = CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude)
        while cutText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: self.font ?? .systemFont(ofSize: 16)], context: nil).size.height >= requiredHeightForText {
            if lastIndex == 0 {
                break
            }
            lastIndex -= 1
            cutText = NSString(string: nsText.substring(with: NSRange(location: 0, length: lastIndex)))
            cutText = (String(cutText) + expandingText) as NSString
        }
        self.text = String(cutText)
        highlight(text: expandingText)
    }
    
    func expand(with text: String) {
        self.numberOfLines = 0
        self.text = text
    }
}
