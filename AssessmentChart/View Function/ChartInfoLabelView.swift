//
//  ChartInfo.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/12.
//

import Foundation
import UIKit

class ChartInfoLabelView: UIView {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let line: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 5, height:  100)
        v.backgroundColor = .black
        v.tag = 2
        return v
    }()
    let insetDistance: CGFloat = 15
    init(frame: CGRect, intProjectCount: [Int], pointInChart: CGPoint, colors: [UIColor]){
        super.init(frame: frame)
        self.setupChartInfo(intProjectCount: intProjectCount, colors: colors)
        self.setupChartInfoIndex(pointInChart: pointInChart)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setupChartInfo(intProjectCount: [Int], colors: [UIColor]){
        let arrayString = ["未發包工程:", "在建工程:", "完工驗收中工程:", "保固中工程:", "結案（保固期滿）:"]
        let arrayInt = intProjectCount.map { "共\($0)件" }
        
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 10
        
        let arrayLbTitle = stringToArray(strings: arrayString, color: colors)
        let arrayLbNumber = stringToArray(strings: arrayInt, color: colors)
        let svLb1 = createVerticalStackView(arrangedSubviews: arrayLbTitle, saping: 10, alignment: .trailing)
        let svLb2 = createVerticalStackView(arrangedSubviews: arrayLbNumber, saping: 10, alignment: .leading)
        let sv = createHorizontalStackView(arrangedSubviews: [svLb1, svLb2])
        
        addSubview(sv)
        sv.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(insetDistance)
        }
    }
    func setupChartInfoIndex(pointInChart: CGPoint){
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.centerX.equalTo(pointInChart.x - insetDistance)
            make.width.equalTo(1)
            make.height.equalTo(300 - pointInChart.y)
        }
    }
    
    func stringToArray(strings: [String], color: [UIColor]) -> [UILabel]{
        var arrayTemp = [UILabel]()
        for (index, string) in strings.enumerated(){
            let lbtemp = UILabel()
            lbtemp.text = string
            lbtemp.font = UIFont.boldSystemFont(ofSize: 16)
            lbtemp.textColor = color[index]
            lbtemp.numberOfLines = 1
            arrayTemp.append(lbtemp)
        }
        return arrayTemp
    }
    func createVerticalStackView(arrangedSubviews: [UIView], saping: CGFloat, alignment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = alignment
        stackView.spacing = 5
        return stackView
    }
    func createHorizontalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
}
