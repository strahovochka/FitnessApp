//
//  CustomImageButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

class CustomImageButton: UIButton {
    
    private var tapped: Bool = false
    weak var unfilledImage: UIImage?
    weak var filledImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.config()
    }
    
    func config() {
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.baseForegroundColor = .clear
        self.setTitle("", for: .normal)
        self.sizeToFit()
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.tintColor = .clear
        self.setImage(unfilledImage, for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: CustomImageButton) {
        if tapped {
            self.setImage(unfilledImage, for: .normal)
            tapped.toggle()
        } else {
            self.setImage(filledImage, for: .normal)
            tapped.toggle()
        }
    }
}
