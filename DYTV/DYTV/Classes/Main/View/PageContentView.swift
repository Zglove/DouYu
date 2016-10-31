//
//  PageContentView.swift
//  DYTV
//
//  Created by people on 2016/10/31.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentViewDraggingNotification(contentView: PageContentView,progress: CGFloat, souceIndex: Int, targetIndex: Int)
}

fileprivate let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    //MARK:- 定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentVc: UIViewController?  //防止循环引用
    fileprivate var startOffsetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate: Bool = false
    
    //MARK:- 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in //让闭包内的self是若引用
    
       //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!  //需要返回确定类型，对结果进行强制解包
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK:- 设置UI界面
extension PageContentView {

    fileprivate func setupUI(){
         //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs {
           parentVc?.addChildViewController(childVc)
        }
        //2.添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
//MARK:- 遵守UICollectionView的dataSource协议
extension PageContentView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //2.给cell设置内容
        for view in cell.contentView.subviews {
        
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
//MARK:- 遵守UICollectionView的Delegate协议
extension PageContentView: UICollectionViewDelegate {

    //用手开始拖动时候调用
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    //只要scrollView滚动就会调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
       //0.判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
       //1.定义获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3.将progress、sourceIndex、targetIndex传递给titleView
      
        delegate?.pageContentViewDraggingNotification(contentView: self, progress: progress, souceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}
//MARK:- 对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex: Int){
        //1.记录需要禁止代理方法
        isForbidScrollDelegate = true
        
        //2.滚动到正确位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        //！该方法会调用didSrollView方法，设置布尔值的目的就是为了区分进入didSrollView的方式是我们用手拖动还是系统自动调的
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}









