//
//  MainTBC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/27.
//

import UIKit

class MainTBC: UITabBarController{
    let mainPGView = MainPGVC().view!
    private var mainView: UIViewController{
        let vc = UIViewController()
        vc.tabBarItem.image = UIImage(systemName: "doc.text")
        vc.view.backgroundColor = .white
        vc.tabBarItem.title = "儀錶板"
        return vc
    }
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
        let secNaviC = MainNC(rootViewController: secView)
        let thirdNaviC = MainNC(rootViewController: thirdView)
        viewControllers = [mainNaviC, secNaviC, thirdNaviC]
        self.tabBar.tintColor = UIColor.black
        self.tabBar.unselectedItemTintColor = .white
        // After iOS 15 disable
        self.tabBar.barTintColor = .brown
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
        lbTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(10)
        }
    }
    func setupPageView(){
        viewControllers?[0].view.addSubview(mainPGView)
        mainPGView.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset( -self.tabBar.frame.size.height )
            make.top.equalTo(lbTitle.snp.bottom).offset(10)
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
    }
}
