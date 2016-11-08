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
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
    
        // 1.确定内容frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        for _ in 0..<2 {
           let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)//将self作为若引用传进去
        contentView.delegate = self
        return contentView
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
        
        //3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
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

//MARK:- 遵守PageTitleView的delegate
extension HomeViewController: PageTitleViewDelegate {

    func titleLabelClickedNotification(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
//MARK:- 遵守PageContentView的delegate
extension HomeViewController: PageContentViewDelegate {

    func pageContentViewDraggingNotification(contentView: PageContentView, progress: CGFloat, souceIndex: Int, targetIndex: Int) {
       pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: souceIndex, targetIndex: targetIndex)
    }
}





