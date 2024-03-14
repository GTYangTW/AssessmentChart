//
//  BorderWithLeftBold.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/1.
//

import UIKit

class BorderWithLeftBold: UIView {
    private var lowerView: UIView!
    private var upperView: UIView!
    private let shiftX: CGFloat = 5
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        createview(color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createview(color: UIColor){
        lowerView = UIView(frame: CGRect(x: shiftX, y: 0, width: frame.size.width , height: frame.size.height))
        lowerView.backgroundColor = color
        upperView = UIView(frame: CGRect(x: lowerView.frame.origin.x + 10,
                                         y: lowerView.frame.origin.y + 2,
                                         width: lowerView.frame.size.width - 12,
                                         height: lowerView.frame.size.height - 4
                                        ))
        upperView.layer.cornerRadius = 10
        lowerView.layer.cornerRadius = 10
        upperView.backgroundColor = .white
        
        addSubview(lowerView)
        addSubview(upperView)
    }
}
