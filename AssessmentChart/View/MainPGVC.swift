//
//  MainPGVC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/29.
//

import UIKit

class MainPGVC: UIPageViewController {
    let viewChart: UIViewController = {
        var vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    let viewAlarm : UIViewController = {
        var vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }()
    lazy var arrayVC : [UIViewController] = {
            var viewControllers = [UIViewController]()
            viewControllers.append(viewChart)
            viewControllers.append(viewAlarm)
            return viewControllers
        }()
    var btn1: UIButton {
        let btn = UIButton()
        btn.setTitle("工程總覽", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitleColor(customBlue, for: .highlighted)
        return btn
    }
    var btn2: UIButton {
        let btn = UIButton()
        btn.setTitle("工程警訊查詢", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitleColor(customBlue, for: .highlighted)
        return btn
    }
    lazy var arrayBtn : [UIButton] = [btn1, btn2]
    let svBtn = UIStackView()
    let uvDiscription = UIView()
    let svLegend = UIStackView()
    let customBlue = UIColor(red: 51/255, green: 108/255, blue: 251/255, alpha: 0.9)
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([arrayVC[0]], direction: .forward, animated: false, completion: nil)
        view.backgroundColor = .blue
        setupStackBtn()
        setupDescription()
        // Do any additional setup after loading the view.
    }
    func setupStackBtn() {
        view.addSubview(svBtn)
        svBtn.axis = .horizontal
        svBtn.alignment = .center
        svBtn.distribution = .fill
        for button in arrayBtn {
            svBtn.addArrangedSubview(button)
        }
        svBtn.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(60)
        }
    }
    func setupDescription(){
        let lbDiscription: UILabel = {
            let label = UILabel()
            label.text = "提醒您"
            return label
        }()
        let lbSubdiscription: UILabel = {
            let label = UILabel()
            label.text = "點擊長條圖可檢視各處標案不同狀態之詳細件數。"
            return label
        }()
        uvDiscription.backgroundColor = .brown
        uvDiscription.addSubview(lbDiscription)
        uvDiscription.addSubview(lbSubdiscription)
        view.addSubview(uvDiscription)
        uvDiscription.snp.makeConstraints { make in
            make.top.equalTo(self.svBtn.snp.bottomMargin)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(100)
        }
        
        view.addSubview(svLegend)
        let lb1 = "未發包工程"
        let lb2 = "完工驗收中工程"
        let lb3 = "結案"
        let lb4 = "在建工程"
        let lb5 = "保固工程"
//        let block1 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 80, height: 60), color: CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
//        let block2 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 80, height: 60), color: CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
//        let block3 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 80, height: 60), color: CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
//        let block4 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 80, height: 60), color: CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
//        let block5 = ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 80, height: 60), color: CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
        let sv1: [String] = [lb1, lb2, lb3, lb4, lb5]
        var arrayLb:[UILabel] = []
        for text in sv1{
            let lbtemp = UILabel()
            lbtemp.font = UIFont(name: "NotoSansTC-Regular", size: 10)
            lbtemp.text = text
            arrayLb.append(lbtemp)
        }
        var svLeft1 = createVerticalStackView(arrangedSubviews: arrayLb)
        svLegend.addSubview(svLeft1)
        svLeft1.snp.makeConstraints { make in
            make.top.equalTo(self.uvDiscription.snp.bottomMargin)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(100)
        }
    }
    
    func createVerticalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
    func createHorizontalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
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

extension MainPGVC : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
}
