//
//  MainViewController.swift
//  DYTV
//
//  Created by people on 2016/10/28.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
    }

    
    private func addChildVc(storyName : String){
        
        /*
         1.通过storyboard获取控制器,
         bundle传nil默认去mainbundle中加载,
         instantiateInitialViewController返回值是可选类型，需拆包
         */
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVc作为子控制器
        addChildViewController(childVc)
    }
}
