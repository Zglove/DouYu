//
//  BaseViewController.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK:- 定义属性
    var contenView: UIView?
    
    //MARK:- 懒加载属性
    fileprivate lazy var animImageView: UIImageView = { [unowned self] in
    
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]//数组中不能放可选类型
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]//一直居中
        return imageView
    }()
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
    }
    

}
//MARK:- 设置UI界面
extension BaseViewController {
    func setupUI(){
        //1.隐藏内容的view
        contenView?.isHidden = true
        
        //2.添加执行动画的imageView
        view.addSubview(animImageView)
        
        //3.给animImageView执行动画
        animImageView.startAnimating()
        
        //4.设置view的backgroundColor
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished(){
       //1.停止动画
        animImageView.stopAnimating()
        
        //2.隐藏animImageView
        animImageView.isHidden = true
        
        //3.显示contenView
        contenView?.isHidden = false
    }
    
}


