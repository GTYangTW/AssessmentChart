//
//  MainNC.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/27.
//

import UIKit
import SnapKit

class MainNC: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupAppearance()
        setupTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func setupAppearance(){
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithDefaultBackground()
        barAppearance.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
    }
    func setupTitle(){
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let titleLabel = UILabel(frame: CGRect(x: 40, y: 0, width: 160, height: 40))
        let imgTitleLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleLabel.text = "工程履约系统"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        imgTitleLogo.image = UIImage(named: "logotp")
        imgTitleLogo.contentMode = .scaleAspectFit
        titleView.addSubview(titleLabel)
        titleView.addSubview(imgTitleLogo)
//        self.navigationBar.topItem?.leftBarButtonItem = leftItem
        self.navigationBar.topItem?.titleView = titleView
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
