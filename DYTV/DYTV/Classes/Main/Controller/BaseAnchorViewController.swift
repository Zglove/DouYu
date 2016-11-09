//
//  BaseAnchorViewController.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
//MARK:- 定义常量
fileprivate let kItemMargin: CGFloat = 10
let kNormalItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH: CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH: CGFloat = kNormalItemW * 4 / 3
fileprivate let kHeadViewH: CGFloat = 50

fileprivate let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeadViewID = "kHeadViewID"

class BaseAnchorViewController: UIViewController {

    //MARK:- 定义属性
    var baseVM: BaseViewModel!  //保证用到baseVM的时候一定有值
    lazy var collectionView: UICollectionView = {[unowned self] in
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)//每个item的大小，但是有2个高度，这里暂不确定
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

    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
        loadData()
    }
}
//MARK:- 设置UI界面
extension BaseAnchorViewController {
     func setupUI(){
        view.addSubview(collectionView)
    }
}
//MARK:- 请求数据,该方法留给子类实现
extension BaseAnchorViewController {
     func loadData(){
       
    }
}
//MARK:- 遵守UICollectionView的协议
extension BaseAnchorViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        //2.给cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1.取出headView,并转成CollectionHeaderView类型
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionHeaderView
        
        
        //2.给headView的group属性赋值的同时即完成了显示的过程
        headView.group = baseVM.anchorGroups[indexPath.section]
        
        return headView
    }
    
}
