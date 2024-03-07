//
//  MainTBC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/27.
//
// MainTBC（下、儀表板） + MainNC(上、Logo) ->  MainPGVC（svbutton） -> viewChartVC ( svLegend + chart)
// 畫面製作的先後順序？？

import UIKit

class MainTBC: UITabBarController{
    // 創建 mainPGVC 實體，再加到 TabbarController 中，使用 addChild(<VC>) 方法。
    let mainPGVC = MainPGVC()
    private var mainView = {
        let vc = UIViewController()
        vc.tabBarItem.image = UIImage(systemName: "doc.text")
        vc.view.backgroundColor = .white
        vc.tabBarItem.title = "儀錶板"
        return vc
    }()
    private var secView: UIViewController{
        let vc = UIViewController()
        vc.view.backgroundColor = .gray
        vc.tabBarItem.title = "Secondary View"
        vc.tabBarItem.image = UIImage(systemName: "doc.text")
        return vc
    }
    private var thirdView: UIViewController{
        let vc = UIViewController()
        vc.view.backgroundColor = .darkGray
        vc.tabBarItem.image = UIImage(systemName: "building.2")
        vc.tabBarItem.title = "Third View"
        return vc
    }
    var lbTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let mainNaviC = MainNC(rootViewController: mainView)
        //let secNaviC = MainNC(rootViewController: secView)
        //let thirdNaviC = MainNC(rootViewController: thirdView)
        self.setViewControllers([mainNaviC, secView, thirdView], animated: true)
        self.tabBar.tintColor = UIColor.black
        self.tabBar.unselectedItemTintColor = .white
        self.addChild(mainPGVC)
        // After iOS 15 disable
        //self.tabBar.barTintColor = .brown
        // Before iOS 15 tabbar properties were set in a different way.
        let barAppearance =  UITabBarAppearance()
        barAppearance.configureWithDefaultBackground()
        barAppearance.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        UITabBar.appearance().scrollEdgeAppearance = barAppearance
        setupLbTitle()
        setupPageView()
        // Do any additional setup after loading the view.
        if let selectedViewController = self.selectedViewController {
            lbTitle.text = selectedViewController.tabBarItem.title
        }
    }

    
    func setupLbTitle(){
        view.addSubview(lbTitle)
        lbTitle.font = UIFont.boldSystemFont(ofSize: 24)
        lbTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
        }
    }
    func setupPageView(){
        viewControllers?.first?.view.addSubview(mainPGVC.view)
        mainPGVC.view.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset( -self.tabBar.frame.size.height )
            // 這邊設置頂板後，PageView 的 button 就無法超出邊界了
            make.top.equalTo(lbTitle.snp.bottom)
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


extension MainTBC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let title = viewController.tabBarItem.title {
            lbTitle.text = title
        }
        if viewController is MainNC {
             // 如果選中的ViewController是UIPageViewController，重新設置它
            setupPageView()
         }
    }
}
