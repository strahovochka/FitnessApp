//
//  CustomTableView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import UIKit

class AdjustableTableView: UITableView {
    
    private var maxHeight = CGFloat(300) {
        didSet {
            self.layoutSubviews()
        }
    }
    private var minHeight = CGFloat(100) {
        didSet {
            self.layoutSubviews()
        }
    }
    
    func setMinHeight(_ height: CGFloat) {
        self.minHeight = height
    }
    
    func setMaxHeight(_ height: CGFloat) {
        self.maxHeight = height
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        if contentSize.height > maxHeight {
            return CGSize(width: contentSize.width, height: maxHeight)
        }
        else if contentSize.height < minHeight {
            return CGSize(width: contentSize.width, height: minHeight)
        }
        else {
            return contentSize
        }
    }
}
