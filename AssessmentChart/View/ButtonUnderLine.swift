//
//  buttonUnderLine.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/29.
//

import UIKit


class ButtonUnderLine: UIView {
    weak var tappedBtn: UIButton?
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let button = tappedBtn,
              let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setStrokeColor(UIColor.systemPink.cgColor)
        context.setLineWidth(button.bounds.width)
        let startPoint = button.convert(CGPoint.zero, to: self)
        context.move(to: CGPoint(x: 0, y: 0))
        let endPoint = CGPoint(x: startPoint.x + button.bounds.width, y: 0)
        context.addLine(to: endPoint)
                
        // 繪製水平直線，(0,0) -> (button width, 0)
//        context.move(to: CGPoint(x: 0, y: 0))
//        context.addLine(to: CGPoint(x: button.bounds.width, y: 0))
        context.strokePath()
    }
  
}
