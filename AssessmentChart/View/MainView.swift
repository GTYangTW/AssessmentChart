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
    let color = ColorReferance()
    let svLegend = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollview.delegate = self
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupDescription()
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

}

extension MainView: UIScrollViewDelegate{
    
}
