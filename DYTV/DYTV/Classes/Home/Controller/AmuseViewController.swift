//
//  AmuseViewController.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
//MARK:- 定义常量
private let kMenuViewH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView: AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
 
        return menuView
    }()
     
}
//MARK:- 设置UI界面
extension AmuseViewController{
    override func setupUI() {
        
        //1.先调用父类的setupUI()
        super.setupUI()
        
        //2.将菜单的view添加到collectionView中
        collectionView.addSubview(menuView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}
//MARK:- 请求数据
extension AmuseViewController {
    override func loadData(){
        //1.给父类中的viewModel赋值
        baseVM = amuseVM
        
        //2.请求数据
       amuseVM.loadAmuseData {
            //2.1刷新表格
            self.collectionView.reloadData()
            
            //2.2调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        
            //2.3数据请求完成
            self.loadDataFinished()
        }
    }
}




