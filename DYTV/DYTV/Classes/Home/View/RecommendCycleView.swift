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

    
    //MARK:- 定义属性
    var cycleTimer: Timer?
    
    
    var cycleModels: [CycleModel]? {
        didSet{
            //1.刷新collectionView
           collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间某一个位置,如果用户一直滚是可以滚到头的，但是这种情况基本不会发生
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeCyclesTimer()
            addCyclesTimer()
        }
    }
    
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
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
      
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
        //如果前面的可选类型没有值就返回0，
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        //来到这里cycleModels一定有值，return cycleModels?.count ?? 0这句话已经做了判断
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        cell.cycleModel = cycleModel
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
        
    }
}

//MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量，滚到一半pageControl显示下一页
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCyclesTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCyclesTimer()
    }
}
//MARK:- 对定时器的操作方法
extension RecommendCycleView {
    
    fileprivate func addCyclesTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    fileprivate func removeCyclesTimer(){
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
    }
    @objc fileprivate func scrollToNext(){
        //1.获取滚动偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
      }

}

