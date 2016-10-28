//
//  PageTitleView.swift
//  DYTV
//
//  Created by people on 2016/10/28.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

fileprivate let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    //MARK:- 定义属性
    fileprivate var titles : [String]
    
    //MARK:- 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false//点击状态栏该scollView是否回到最上面
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
   //MARK:- 自定义构造函数,需让系统自动补全init?(coder aDecoder: NSCoder)方法
    init(frame : CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 设置UI界面
extension PageTitleView{

    fileprivate func setupUI(){
        
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        setupTitleLabels()
        
        //3.设置底线和滚动滑块
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels(){
        
        //0.确定label的一些frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        var labelX : CGFloat = 0
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerated(){
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.设置label的frame
            labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.把label添加到scrollView上
            scrollView.addSubview(label)
            
            //5.将label存储在titleLabels中
            titleLabels.append(label)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加ScrollLine
        //2.1获取第一个label,进行guard校验
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        
    }
}
