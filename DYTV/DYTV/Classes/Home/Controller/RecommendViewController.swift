//
//  RecommendViewController.swift
//  DYTV
//
//  Created by people on 2016/11/1.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10
fileprivate let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kNormalItemH: CGFloat = kItemW * 3 / 4
fileprivate let kPrettyItemH: CGFloat = kItemW * 4 / 3
fileprivate let kHeadViewH: CGFloat = 50

fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeadViewID = "kHeadViewID"

class RecommendViewController: UIViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var recommendVM = RecommenViewModel()
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)//每个item的大小，但是有2个高度，这里暂不确定
        layout.minimumLineSpacing = 0//每行之间的间距
        layout.minimumInteritemSpacing = kItemMargin//每两个item之间的最小间距
        //设置sectionInset是让item左右各有10间距，而不是2个item中间占30.两边没有
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        
        //2.创建UICollectionView，宽高自适应父视图
        
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //nil代表从mainBundle中去寻找
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        return collectionView
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
        //设置UI界面
        setupUI()
        
        //发送网络请求
       loadData()
    }
}
//MARK:- 设置UI界面
extension RecommendViewController {

    fileprivate func setupUI(){
    //1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
    }
}
//MARK:- 请求数据
extension RecommendViewController {
    fileprivate func loadData(){
       recommendVM.requestData()
    }
}


//MARK:- 遵守UICollectionView的协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.定义cell
        var cell: UICollectionViewCell!
        
        //2.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath)
      
        return headView
    }
    
    //布局时不能确定的item大小在这里确定 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
           return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
          return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}







