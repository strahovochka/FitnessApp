//
//  HeaderView.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak private var mainTitleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: Identifiers.NibNames.registrationHeader, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Unable to convert nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    func config(mainTitle: String?, subtitle: String?) {
        if let title = mainTitle, let subtitle = subtitle {
            self.mainTitleLabel.text = title.uppercased()
            self.subtitleLabel.text = subtitle
        } else {
            self.mainTitleLabel.text = "Main title".uppercased()
            self.subtitleLabel.text = "Subtitle"
        }
    }
    
}
