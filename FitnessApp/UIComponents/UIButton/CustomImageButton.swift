//
//  CustomImageButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

class CustomImageButton: UIButton {
    
    private var tapped: Bool = false
    @IBInspectable weak private var unfilledImage: UIImage?
    @IBInspectable weak private var filledImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configUI()
    }
    
    private func configUI() {
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
        } else {
            self.setImage(filledImage, for: .normal)
        }
        tapped.toggle()
    }
    
    func setImaged(filled: UIImage?, unfilled: UIImage?) {
        self.unfilledImage = unfilled
        self.filledImage = filled
        self.configUI()
        self.updateConfiguration()
    }
}
