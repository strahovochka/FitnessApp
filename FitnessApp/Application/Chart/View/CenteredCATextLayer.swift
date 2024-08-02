//
//  CenteredCATextLayer.swift
//  FitnessApp
//
//  Created by Jane Strashok on 02.08.2024.
//

import UIKit

class CenteredCATextLayer: CATextLayer {
    override func draw(in context: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height-fontSize)/2 

        context.saveGState()
        context.translateBy(x: 0, y: yDiff)
        super.draw(in: context)
        context.restoreGState()
    }
}
