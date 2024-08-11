//
//  UILable+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 11.08.2024.
//

import UIKit

extension UILabel {
    var highlight: UIColor? { return .primaryYellow }
    
    private func numberOfVisibleLines(of string: String) -> Int {
        let size = CGSize(width: frame.width, height: .greatestFiniteMagnitude)
        let text = string as NSString
        let textHeight = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font ?? .systemFont(ofSize: 16)], context: nil).height
        let lineHeight = font.lineHeight
        return (Int(ceil(textHeight/lineHeight)))
    }
    
    private func highlight(text: String) {
        guard let labelText = self.text else { return }
        let range = (labelText as NSString).range(of: text)
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.addAttributes([.foregroundColor: highlight ?? .primaryYellow], range: range)
        self.attributedText = attributedText
    }
    
    func addExpandingText(_ expandingText: String, after text: String) {
        var expandableText = text
        var truncatedText = text
        while numberOfVisibleLines(of: expandableText) > self.numberOfLines {
            truncatedText.popLast()
            expandableText = truncatedText + expandingText
        }
        self.text = expandableText
        highlight(text: expandingText)
    }
    
    func expand(with text: String) {
        self.numberOfLines = 0
        self.text = text
    }
}
