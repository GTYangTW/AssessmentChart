//
//  BorderWithLeftBold.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/1.
//

import UIKit

class BorderWithLeftBold: UIView {
    private var upperView: UIView!
    private var lowerView: UIView!
    private let shiftX: CGFloat = 5
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        createview(color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createview(color: UIColor){
        upperView = UIView(frame: CGRect(x: shiftX, y: 0, width: frame.size.width, height: frame.size.height))
        upperView.backgroundColor = color
        lowerView = UIView(frame: CGRect(x: upperView.frame.origin.x + 10,
                                         y: upperView.frame.origin.y + 2,
                                         width: upperView.frame.size.width - 12,
                                         height: upperView.frame.size.height - 4
                                        ))
        lowerView.layer.cornerRadius = 10
        upperView.layer.cornerRadius = 10
        lowerView.backgroundColor = .white
        
        addSubview(upperView)
        addSubview(lowerView)
    }
}
