//
//  FunnyViewController.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
//MARK:- 定义常量
private let kTopMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

   //MARK:- 懒加载属性
    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    
}
//MARK:- 设置UI界面
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}
//MARK:- 请求数据
extension FunnyViewController {
     override func loadData(){
        //1.给父类中的viewmodel进行赋值
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData{
            //2.1刷新表格
            self.collectionView.reloadData()
            
            //2.2.数据请求完成
            self.loadDataFinished()
        }
     }
}












