//
//  CollectionCycleCell.swift
//  DYTV
//
//  Created by people on 2016/11/7.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

   //MARK:- 定义模型属性
    var cycleModel: CycleModel? {
        didSet{
            
           titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
            let resource = ImageResource.init(downloadURL: iconURL as URL)
            iconImageView.kf.setImage(with: resource, placeholder: UIImage(named: "Img_default"))
            
        }
    }

}
