//
//  MainPGVC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/29.
//

import UIKit

class MainPGVC: UIPageViewController {
    let viewChart = {
        let vc = UIViewController()
        return vc
    }()
    let viewAlarm = {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }()
    var arrayVC : [UIViewController]{
        var viewControllers = [UIViewController]()
        viewControllers.append(viewChart)
        viewControllers.append(viewAlarm)
        return viewControllers
    }
    var btn1: UIButton {
        let btn = UIButton()
        btn.setTitle("工程總覽", for: .normal)
        return btn
    }
    var btn2: UIButton {
        let btn = UIButton()
        btn.setTitle("工程警訊查詢", for: .normal)
        return btn
    }
    lazy var uvDiscription = BorderWithLeftBold(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: 100), color: color.customYellow)
    
    let color = ColorReferance()
    lazy var arrayBtn : [UIButton] = [btn1, btn2]
    let svBtn = UIStackView()
    let svLegend = UIStackView()
    let uv = UIView()
    var buttonUnderLine = ButtonUnderLine()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        setViewControllers([arrayVC[0]], direction: .forward, animated: true, completion: nil)
        view.isUserInteractionEnabled = true
        viewChart.view.isUserInteractionEnabled = true
        setupStackBtn()
        setupDescription()
        // Do any additional setup after loading the view.
    }
    func setupStackBtn() {
        view.addSubview(svBtn)
        svBtn.axis = .horizontal
        svBtn.alignment = .center
        svBtn.distribution = .fillEqually
        for button in arrayBtn {
            button.setTitleColor(.darkGray, for: .normal)
            button.setTitleColor(color.customBlue, for: .selected)
            button.addTarget(self, action: #selector(tappedBtn), for: .touchUpInside)
            svBtn.addArrangedSubview(button)
        }
        svBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
    }
    @objc
    func tappedBtn(_ sender: UIButton) {
        //print("Sender")
        for btn in arrayBtn {
            btn.isSelected = false
        }
        svBtn.subviews.forEach { subview in
            if subview is ButtonUnderLine {
                subview.removeFromSuperview()
            }
        }
        buttonUnderLine.tappedBtn = sender
        svBtn.addSubview(buttonUnderLine)
        sender.isSelected = true
        buttonUnderLine.snp.makeConstraints { make in
            make.width.equalTo(sender.snp.width)
            make.height.equalTo(5)
            make.centerX.equalTo(sender.snp.centerX)
            make.centerY.equalTo(sender.snp.bottom)
        }
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
        viewChart.view.addSubview(uvDiscription)
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
        /*
        viewChart.view.addSubview(svLegend)
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
    }
    /*
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
     */
    func labelSize(label: UILabel) -> CGSize {
        let labelWidth = view.frame.width - 40
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelBounds = label.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font], context: nil)
        return labelBounds?.size ?? CGSize.zero
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension MainPGVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrayVC.firstIndex(of: viewController) else {
            return nil
        }
        switch currentIndex{
        case 0:
            return arrayVC[1]
        case 1:
            return nil
        default:
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrayVC.firstIndex(of: viewController) else {
            return nil
        }
        switch currentIndex{
        case 0:
            return arrayVC[1]
        case 1:
            return nil
        default:
            return nil
        }
    }
}
