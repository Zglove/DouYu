//
//  RecommendCycleView.swift
//  DYTV
//
//  Created by people on 2016/11/4.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

fileprivate let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    //MARK:- 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
       
    
    
    override func awakeFromNib() {
         super.awakeFromNib()
   
        /*
         typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
         UIViewAutoresizingNone                 = 0,
         UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
         UIViewAutoresizingFlexibleWidth        = 1 << 1,
         UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
         UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
         UIViewAutoresizingFlexibleHeight       = 1 << 4,
         UIViewAutoresizingFlexibleBottomMargin = 1 << 5
         };
         */
        //1.设置该控件不随父控件的拉伸而拉伸（另一种方法是在xib中去掉所有布局）
        autoresizingMask = UIViewAutoresizing(rawValue: UInt(0))
        
        //2.注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        
      
    }
    
    //在这里设置尺寸，在awakeFromNib中拿到的是xib中的尺寸并非真实尺寸
    override func layoutSubviews() {
       
        super.layoutSubviews()
        
        //3.设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        /*
         这段代码已经在xib中设置了
         layout.minimumLineSpacing = 0
         layout.minimumInteritemSpacing = 0
         layout.scrollDirection = .horizontal
         collectionView.isPagingEnabled = true
         */

    }

}
//MARK:- 提供一个快速创建view的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
       return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//MARK:- 遵守UICollectionView的数据源代理协议
extension RecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
        
    }
}
