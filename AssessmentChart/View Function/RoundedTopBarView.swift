//
//  RoundedTopBarView.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/22.
//

import Foundation
import UIKit

class RoundedTopBarView: UIView {
    var color: CGColor = UIColor.clear.cgColor
        
    init(frame: CGRect, color: CGColor) {
        super.init(frame: frame)
        self.color = color
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        // 左上角
        path.move(to: CGPoint(x: 0, y: 0))
        // 上方直線
        path.addLine(to: CGPoint(x: frame.width , y: 0))
        // 右邊直線
        path.addLine(to: CGPoint(x: frame.width, y: frame.height ))
        // 底部弧線
        path.addArc(withCenter: CGPoint(x: frame.width / 2 , y: frame.height / 2),
                    radius: frame.height / 2,
                    startAngle: 0,
                    endAngle: CGFloat.pi,
                    clockwise: false)
        // 左邊直線
        path.addLine(to: CGPoint(x: 0, y: frame.height ))
        
        path.close()
        UIColor(cgColor: color).setFill()
        path.fill()
    }
}
extension UIView {
    func asImage(self: UIView) -> UIImage {
        // 將畫布設置為與視圖相同大小的點陣圖
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        // 在畫布上繪製視圖
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        layer.render(in: context)
        
        // 從畫布中創建 UIImage
        guard let renderedImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        return renderedImage
    }
}
