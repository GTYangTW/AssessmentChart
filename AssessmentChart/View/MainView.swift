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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollview.delegate = self
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

}

extension MainView: UIScrollViewDelegate{
    
}
