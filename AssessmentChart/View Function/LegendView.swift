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

class LegendView {
    let view = UIView()
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView()
        return view
    }()
    let colorBlockLegend = ColorBlockLegend()
    init(text: String, color: UIColor) {
        textLabel.text = text
        
        colorBlockLegend.color = color.cgColor
//        colorView.backgroundColor = color
        view.addSubview(textLabel)
        view.addSubview(colorView)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(colorView.snp.right).offset(8)
            make.right.lessThanOrEqualToSuperview()
        }
//        colorView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview()
//            make.width.height.equalTo(20)
//        }
        colorBlockLegend.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    view.addSubview(svLegend)
    let lb1 = "未發包工程"
    let lb2 = "完工驗收中工程"
    let lb3 = "結案"
    let lb4 = "在建工程"
    let lb5 = "保固工程"
    let lb6 = ""
    let block1 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 40, height: labelSize(label: lbDiscription).height), color: CGColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    let block2 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 40, height: labelSize(label: lbDiscription).height), color: CGColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    let block3 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 40, height: labelSize(label: lbDiscription).height), color: CGColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    let block4 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 40, height: labelSize(label: lbDiscription).height), color: CGColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    let block5 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 40, height: labelSize(label: lbDiscription).height), color: CGColor(red: 1, green: 1, blue: 1, alpha: 1.0))
    let block6 = UIView()
    
    let arrayBlock1 = [block1, block2, block3]
    let arrayBlock2 = [block4, block5, block6]
    let sv1: [String] = [lb1, lb2, lb3]
    let sv2: [String] = [lb4, lb5, lb6]
    let arrayLb1 = stringToArray(strings: sv1)
    let arrayLb2 = stringToArray(strings: sv2)
    
    let svLeft1 = createVerticalStackView(arrangedSubviews: arrayBlock1)
    let svLeft3 = createVerticalStackView(arrangedSubviews: arrayBlock2)
    let svLeft2 = createVerticalStackView(arrangedSubviews: arrayLb1)
    let svLeft4 = createVerticalStackView(arrangedSubviews: arrayLb2)
    
    let svLeft = createHorizontalStackView(arrangedSubviews: [svLeft1, svLeft2])
    let svRight = createHorizontalStackView(arrangedSubviews: [svLeft3, svLeft4])
    
    let svAll = createHorizontalStackView(arrangedSubviews: [svLeft, svRight])
    
    svLegend.addSubview(svAll)
    svAll.snp.makeConstraints { make in
        make.top.centerX.equalToSuperview()
        make.width.lessThanOrEqualTo(svLegend.snp.width)
    }
    svLegend.snp.makeConstraints { make in
        make.top.equalTo(self.uvDiscription.snp.bottom)
        make.left.right.bottom.equalToSuperview()
    }
     */
    func createVerticalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
    
    func createHorizontalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
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

