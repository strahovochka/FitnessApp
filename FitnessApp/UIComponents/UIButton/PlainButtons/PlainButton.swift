//
//  ParentPlainButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

class PlainButton: UIButton {

    @IBInspectable var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.config()
    }
    
    func config() {
        self.titleLabel?.textAlignment = .center
    }

}
