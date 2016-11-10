//
//  RoomNormalViewController.swift
//  DYTV
//
//  Created by people on 2016/11/10.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1.隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        /*
         //2.依然保持手势
         navigationController?.interactivePopGestureRecognizer?.delegate = self
         navigationController?.interactivePopGestureRecognizer?.isEnabled = true
         */
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //1.展示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
