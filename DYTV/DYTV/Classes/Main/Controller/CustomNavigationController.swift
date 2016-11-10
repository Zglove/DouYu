//
//  CustomNavigationController.swift
//  DYTV
//
//  Created by people on 2016/11/10.
//  Copyright © 2016年 people2000. All rights reserved.
//
/*
 push出来的控制器系统会自己在其边缘处添加拖拉手势,但是如果导航条被隐藏之后则没有
 */
import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //2.获取手势所在的view
        guard let gesView = systemGes.view else { return }
        
        //3.获取target/action
            //3.1利用运行时机制查看所有的属性名称
            /*
            var count: UInt32 = 0
            let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
            for i in 0..<count {
                let ivar = ivars[Int(i)]
                let name = ivar_getName(ivar)
                print(String(cString: name!))
            }
             */
            let targets = systemGes.value(forKeyPath: "_targets") as? [NSObject]
            guard let targetObjc = targets?.first else { return }
        
        
            /*
             print(targets)的结果：_targets中有一个元素，这个元素中又有action，target两个属性
            Optional(<__NSArrayM 0x600000049db0>(
             
                      (action=handleNavigationTransition:,
                 target=<_UINavigationInteractiveTransition 0x7f8951f2c280>)
             
                )
             )
             */
            //3.2取出target
            guard let target = targetObjc.value(forKeyPath: "target") else { return }
            
            //3.3取出action,直接取不行，干脆直接创建一个
//            guard let action = targetObjc.value(forKeyPath: "action") as? Selector else { return }
            let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
