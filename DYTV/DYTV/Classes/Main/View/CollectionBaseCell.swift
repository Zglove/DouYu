//
//  CollectionBaseCell.swift
//  DYTV
//
//  Created by people on 2016/11/4.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionBaseCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    //MARK:- 定义模型
    
    var anchor: AnchorModel? {
    
        didSet{
            //0.校验模型是否有值
            guard let anchor = anchor else {return}
            
            //1.取出在线人数
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2.显示昵称
            nicknameLabel.text = anchor.nickname
     
            //3.设置封面图片
            
            guard let iconURL = NSURL(string: anchor.vertical_src) else {return}
            let resource = ImageResource.init(downloadURL: iconURL as URL)//把NSURL在在转成swift中的URL
            /*
             swift类型去掉了NS前缀，所以在用OC类型的时候需要转化一下
             guard let iconURL = URL(string: anchor.vertical_src) else {return}
             let resource = ImageResource.init(downloadURL: iconURL)
             */
            iconImageView.kf.setImage(with: resource)
        }
    }
    
    
}
