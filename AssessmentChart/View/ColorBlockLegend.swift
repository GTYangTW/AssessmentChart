//
//  ColorBlockLegend.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/29.
//

import UIKit

class ColorBlockLegend: UIView {
    var color: CGColor!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(color)
    }
    convenience init(frame: CGRect, color: CGColor) {
         self.init(frame: frame)
         self.color = color
         setupView(color)
     }
    
    private func setupView(_ color: CGColor) {
        layer.backgroundColor = color
        layer.cornerRadius = self.layer.borderWidth / 4
        layer.borderWidth = 0.1
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
    }
}
