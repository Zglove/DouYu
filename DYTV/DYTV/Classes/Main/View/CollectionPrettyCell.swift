//
//  CollectionPrettyCell.swift
//  DYTV
//
//  Created by people on 2016/11/2.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {

    //MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK:- 定义模型属性,重写父类的属性注意2点：1.override   2.super.anchor = anchor
   override var anchor: AnchorModel? {
        didSet{
          
            //1.将属性传递给父类
            super.anchor = anchor
            //2.显示城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
           
        }
    }
}
