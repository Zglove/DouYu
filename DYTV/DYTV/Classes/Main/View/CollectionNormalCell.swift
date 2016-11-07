//
//  CollectionNormalCell.swift
//  DYTV
//
//  Created by people on 2016/11/2.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionNormalCell: CollectionBaseCell {

    //MARK:- 控件的属性
   
    @IBOutlet weak var roomnameLabel: UILabel!
    
    
    //MARK:- 定义模型属性
  override var anchor: AnchorModel?{
        didSet{
             //1.将属性传递给父类
            super.anchor = anchor
            //2.房间名称
            roomnameLabel.text = anchor?.room_name
        }
    }

}
