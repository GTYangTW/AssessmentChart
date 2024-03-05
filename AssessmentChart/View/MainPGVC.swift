//
//  MainPGVC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/29.
//

import UIKit

class MainPGVC: UIPageViewController {
    let viewAlarm = {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }()
    let mainVC = MainView()
    var arrayVC : [UIViewController]{
        var viewControllers = [UIViewController]()
        viewControllers.append(mainVC)
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
    let color = ColorReferance()
    lazy var arrayBtn : [UIButton] = [btn1, btn2]
    let svBtn = UIStackView()
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

        setupStackBtn()
        // Do any additional setup after loading the view.
    }
    // PageView 也能設置 constraint 但是會因為畫面切換，導致 constraint 重新計算，再創 PageView 實體的類別設置 constraint 才對
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
        markPageButton(arrayBtn[0])
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
        markPageButton(sender)
        var direction = NavigationDirection.forward
        if let index = arrayBtn.firstIndex(of: sender){
            switch index {
            case 0:
                direction = NavigationDirection.reverse
            case 1:
                direction = NavigationDirection.forward
            default:
                direction = NavigationDirection.reverse
            }
            //pagecontrol 跳轉頁面控制功能，直接跳頁數
            setViewControllers([arrayVC[index]], direction: direction, animated: true, completion: nil)
        }
    }
    func markPageButton(_ sender: UIButton){
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
            markPageButton(arrayBtn[1])
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
            markPageButton(arrayBtn[1])
            return arrayVC[1]
        case 1:
            return nil
        default:
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let viewController = pageViewController.viewControllers?.first,
              let index = arrayVC.firstIndex(of: viewController) else { return }
        markPageButton(arrayBtn[index])
    }
}
