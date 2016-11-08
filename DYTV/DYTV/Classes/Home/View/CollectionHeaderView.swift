//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by people on 2016/11/2.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    //MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    //MARK:- 定义模型属性
    var group: AnchorGroup? {
        didSet{
           titleLabel.text = group?.tag_name
            //??的作用：若group?.icon_name取不到值用home_header_normal代替
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
//MARK:- 从xib中快速创建的类方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView{
       return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
