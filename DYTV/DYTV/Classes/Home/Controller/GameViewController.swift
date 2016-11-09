//
//  GameViewController.swift
//  DYTV
//
//  Created by people on 2016/11/8.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
//MARK:- 定义常量
fileprivate let kEdgeMargin: CGFloat = 10
fileprivate let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
fileprivate let kItemH: CGFloat = kItemW * 6 / 5
fileprivate let kHeaderViewH: CGFloat = 50
fileprivate let kGameViewH: CGFloat = 90

fileprivate let kGameCellID: String = "kGameCellID"
fileprivate let kHeaderViewID: String = "kHeaderViewID"

class GameViewController: BaseViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        /*
         [unowned self] in 和[weak self] in 都可将self弱引用，用后者需要对self解包
         */
        //1.创建布局
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2.创建UICollectionView
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
       collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //3.注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常用"
        headerView.moreBtn.isHidden = true
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        return headerView
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
        
        
    }
}
//MARK:- 设置UI界面
extension GameViewController {
      override func setupUI(){
        
        //0.给父类的contenView赋值
        contenView = collectionView
 
        //1.添加UICollectionView
       view.addSubview(collectionView)
        
        //2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        
        //3.将常用游戏的view添加到collectionView上
        collectionView.addSubview(gameView)
        
        //3.设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        //4.调用父类的setupUI
        super.setupUI()
    }
}
//MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData(){
      gameVM.loadAllGameData { 
     
        //1.展示全部游戏
        self.collectionView.reloadData()
        
        //2.展示常用游戏
        /*
             var tempArray = [BaseGameModel]()
             for index in 0..<10 {
                 tempArray.append(self.gameVM.games[index])
             }
             self.gameView.groups = tempArray
         */
        self.gameView.groups = Array(self.gameVM.games[0..<10])//取出来的是ArraySlice类型所以需转成Array
        
        //3.数据请求完成
        self.loadDataFinished()
        
    }
  }
}

//MARK:- 遵守UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
       let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}




