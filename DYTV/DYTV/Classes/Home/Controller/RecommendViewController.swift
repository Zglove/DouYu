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
fileprivate let kCycleViewH: CGFloat = kScreenW * 3 / 8
fileprivate let kGameViewH: CGFloat = 90

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
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
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
        
        //2.将cycleView添加到collectionView中,此处cycleView依然显示不出来，需要去掉cycleView所有的布局
        collectionView.addSubview(cycleView)
        
        //3.将gameview添加到collectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}
//MARK:- 请求数据
extension RecommendViewController {
    
    
    fileprivate func loadData(){
        
        //1.请求推荐数据
       recommendVM.requestData {
            //1>显示推荐数据
            self.collectionView.reloadData()
        
            //2>将数据传递给gameview
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
    
    
    
    
}


//MARK:- 遵守UICollectionView的协议
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        print("一共\(recommendVM.anchorGroups.count)组")
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.anchorGroups[section]
//        print("第\(section)组有\(group.anchors.count)个主播")
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
       
        //2.定义cell
        var cell: CollectionBaseCell!
        
        //3.取出cell
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }else{
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        //4.对cell中的模型进行赋值
        cell.anchor = anchor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1.取出headView,并转成CollectionHeaderView类型
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionHeaderView
        
        
        //2.给headView的group属性赋值的同时即完成了显示的过程
        headView.group = recommendVM.anchorGroups[indexPath.section]
        
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







