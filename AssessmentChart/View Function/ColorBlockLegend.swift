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
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    convenience init(frame: CGRect, color: CGColor) {
         self.init(frame: frame)
         self.color = color
         setupView()
     }
    
    private func setupView() {
        layer.backgroundColor = color
        layer.cornerRadius = 10
        layer.borderWidth = 0.1
        layer.masksToBounds = true
    }
}
