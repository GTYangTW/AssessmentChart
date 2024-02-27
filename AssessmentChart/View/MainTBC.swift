//
//  MainTBC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/27.
//

import UIKit

class MainTBC: UITabBarController{
    private var mainView: UIViewController{
        let vc = MainView()
        vc.tabBarItem.image = UIImage(systemName: "doc.text")
        vc.tabBarItem.title = "儀錶板"
        return vc
    }
    private var secView: UIViewController{
        let vc = UIViewController()
        vc.view.backgroundColor = .darkGray
        vc.tabBarItem.title = "Secondary View"
        vc.tabBarItem.image = UIImage(systemName: "doc.text")
        return vc
    }
    private var thirdView: UIViewController{
        let vc = UIViewController()
        vc.view.backgroundColor = .gray
        vc.tabBarItem.image = UIImage(systemName: "building.2")
        vc.tabBarItem.title = "Third View"
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var mainNaviC = MainNC(rootViewController: mainView)
        var secNaviC = MainNC(rootViewController: secView)
        var thirdNaviC = MainNC(rootViewController: thirdView)
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
        // Do any additional setup after loading the view.
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
