//
//  RecommendGameView.swift
//  DYTV
//
//  Created by people on 2016/11/7.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
//MARK:- 定义常量
fileprivate let kGameCellID: String = "kGameCellID"
fileprivate let kEdgeInsetMargin: CGFloat = 10

class RecommendGameView: UIView {

    //MARK:- 定义数据属性
    var groups: [BaseGameModel]? {
        didSet{
            
            //刷新表格
           collectionView.reloadData()
            
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件的拉伸而拉伸.   0是none的枚举值
        autoresizingMask = .init(rawValue: 0)
        
        //注册cell,布局的属性在xib中设置了   
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }

}
//MARK:- 快速创建xib的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
//MARK:- 遵守collectionView的dataSouces
extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }
}

