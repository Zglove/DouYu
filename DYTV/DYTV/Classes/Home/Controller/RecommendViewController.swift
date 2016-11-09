//
//  RecommendViewController.swift
//  DYTV
//
//  Created by people on 2016/11/1.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

fileprivate let kCycleViewH: CGFloat = kScreenW * 3 / 8
fileprivate let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var recommendVM = RecommenViewModel()
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
    
   
}
//MARK:- 设置UI界面
extension RecommendViewController {

    override func setupUI(){
        //1先调用super.setupUI()
        super.setupUI()
        
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
    
    
    override func loadData(){
        
        //0.给父类中的ViewModel进行赋值
        baseVM = recommendVM
        
        //1.请求推荐数据
       recommendVM.requestData {
            //1>显示推荐数据
            self.collectionView.reloadData()
        
            //2>将数据传递给gameview
                var groups = self.recommendVM.anchorGroups
                
                //2.1>.移除前两组数据
                groups.remove(at: 0)
                groups.remove(at: 0)
                
                //2.2>.添加‘更多’组
                let moreGroup = AnchorGroup()
                moreGroup.tag_name = "更多"
                groups.append(moreGroup)
                
                self.gameView.groups = groups
        }
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }

}

//MARK:- 完善UICollectionView的协议
extension RecommendViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1.取出cell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            //2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
  //布局时不能确定的item大小在这里确定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
           return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else{
          return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}







