//
//  HomeViewController.swift
//  DYTV
//
//  Created by people on 2016/10/28.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.purple
        return titleView
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
     
      //设置UI界面
      setupUI()
  
    }
}

//MARK:- 设置UI界面
extension HomeViewController{
    
    fileprivate func setupUI(){
    
        //0.不需要调整UIScrollView的内边距,因为当有导航栏存在系统会自动下沉scrollView 44 内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
    }
    
    fileprivate func setupNavigationBar(){
    
        //设置左侧的Item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        //设置右侧的Item
        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
