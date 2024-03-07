//
//  ViewController.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/27.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    let mainScrollview = UIScrollView()
    lazy var uvDiscription = BorderWithLeftBold(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: 100), color: color.customYellow)
    var color: ColorReferance!
    let svLegend = UIStackView()
    let legendDiscription = UIView()
    lazy var legendBlock = LegendViewBlock(text: "未發包工程", color: .darkGray)
    lazy var legendBlock1 = LegendViewBlock(text: "在建工程", color: color.customYellow)
    lazy var legendBlock2 = LegendViewBlock(text: "完工驗收中工程", color: color.customGreen)
    lazy var legendBlock3 = LegendViewBlock(text: "保固中工程", color: color.customRed)
    lazy var legendBlock4 = LegendViewBlock(text: "結案（保固期滿）", color: color.customBlue)
    lazy var arrayLegend: [LegendViewBlock] = [legendBlock, legendBlock1, legendBlock2, legendBlock3, legendBlock4]
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.color = ColorReferance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollview.delegate = self
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupDescription()
        setupLegend()
    }
    // frame 與 constranint 先後順序？？
    func setupLegend() {
        let svSpilt = splitArrayToStackview(array: arrayLegend)
        svLegend.addArrangedSubview(svSpilt)
        view.addSubview(legendDiscription)
        legendDiscription.addSubview(svLegend)
        svLegend.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
        }
        legendDiscription.snp.makeConstraints { make in
            make.top.equalTo(uvDiscription.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(svSpilt.snp.height)
        }
    }
    func splitArrayToStackview(array: [UIView]) -> UIStackView {
        let halfCount: Int
        if array.count % 2 == 0 {
            halfCount = array.count / 2
        } else {
            halfCount = (array.count + 1) / 2
        }
        let firstHalf = Array(arrayLegend.prefix(halfCount))
        let secondHalf = Array(arrayLegend.suffix(from: halfCount))
        let svVerFirst = createVerticalStackView(arrangedSubviews: firstHalf)
        let svVerSecond = createVerticalStackView(arrangedSubviews: secondHalf)
        let svAll = createHorizontalStackView(arrangedSubviews: [svVerFirst, svVerSecond])
        return svAll
    }
    func setupDescription(){
        let lbDiscription: UILabel = {
            let label = UILabel()
            label.text = "提醒您"
            label.textColor = color.customYellow
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        let lbSubdiscription: UILabel = {
            let label = UILabel()
            label.text = "點擊長條圖可檢視各處標案不同狀態之詳細件數。"
            label.numberOfLines = 0
            return label
        }()
        uvDiscription.addSubview(lbDiscription)
        uvDiscription.addSubview(lbSubdiscription)
        view.addSubview(uvDiscription)
        uvDiscription.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(90)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        lbDiscription.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.right.lessThanOrEqualToSuperview().offset(15)
            make.height.equalTo(labelSize(label: lbDiscription).height)
        }
        lbSubdiscription.snp.makeConstraints { make in
            make.top.equalTo(lbDiscription.snp.bottomMargin).offset(20)
            make.left.right.equalToSuperview().offset(15)
            make.height.lessThanOrEqualTo(50)
        }
    }
    func labelSize(label: UILabel) -> CGSize {
        let labelWidth = view.frame.width - 40
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelBounds = label.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font], context: nil)
        return labelBounds?.size ?? CGSize.zero
    }
    
    func createVerticalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
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

extension MainView: UIScrollViewDelegate{
    
}

enum number{
    case oddNumber
    case evenNumber
}
