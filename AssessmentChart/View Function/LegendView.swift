//
//  LegendView.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/4.
//

import Foundation
import UIKit
import SnapKit

/*
// TODO: 做成class
let svLegend = UIStackView()
func setupDescription(){
    let lbDiscription: UILabel = {
        let label = UILabel()
        label.text = "提醒您"
        label.textColor = customYellow
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let lbSubdiscription: UILabel = {
        let label = UILabel()
        label.text = "點擊長條圖可檢視各處標案不同狀態之詳細件數。"
        label.numberOfLines = 0
        return label
    }()
//        uvDiscription.backgroundColor = .brown
    uvDiscription.addSubview(lbDiscription)
    uvDiscription.addSubview(lbSubdiscription)
    view.addSubview(uvDiscription)
    uvDiscription.snp.makeConstraints { make in
        make.top.equalTo(self.svBtn.snp.bottomMargin)
        make.left.right.equalToSuperview()
        make.height.equalTo(100)
    }
    lbDiscription.snp.makeConstraints { make in
        make.top.left.equalToSuperview().offset(15)
        make.height.equalTo(labelSize(label: lbDiscription).height)
    }
    lbSubdiscription.snp.makeConstraints { make in
        make.top.equalTo(lbDiscription.snp.bottomMargin).offset(20)
        make.left.right.equalToSuperview().offset(15)
        make.height.lessThanOrEqualTo(50)
    }
    
 */
// 創造類別的內容
class LegendViewBlock: UIView {
    private let view = UIView()
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    let colorBlock = UIView()
    
    init(frame: CGRect = CGRect(x: 0, y: 0, width: 120, height: 60), text: String, color: UIColor) {
        super.init(frame: frame)
        textLabel.text = text
        setupBlock(frame: frame, color: color)
    }
    // UIView 本身就是 View，則無 View 屬性
    func setupBlock(frame: CGRect, color: UIColor){
        colorBlock.backgroundColor = color
        addSubview(textLabel)
        addSubview(colorBlock)
        self.textLabel.snp.makeConstraints { make in
            make.left.equalTo(colorBlock.snp.right).offset(8)
            make.top.equalToSuperview().offset(10)
            make.right.lessThanOrEqualToSuperview()
        }
        colorBlock.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func stringToArray(strings: [String]) -> [UILabel]{
        var arrayTemp = [UILabel]()
        for string in strings{
            let lbtemp = UILabel()
            lbtemp.font = UIFont(name: "NotoSansTC-Regular", size: 10)
            lbtemp.text = string
            lbtemp.numberOfLines = 1
            arrayTemp.append(lbtemp)
        }
        return arrayTemp
    }
    func labelSize(label: UILabel) -> CGSize {
        let labelWidth = view.frame.width - 40 // 根据左右间距计算 Label 的宽度
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelBounds = label.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font], context: nil)
        return labelBounds?.size ?? CGSize.zero
    }
}

