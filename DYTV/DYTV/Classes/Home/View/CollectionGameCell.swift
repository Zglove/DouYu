//
//  CollectionGameCell.swift
//  DYTV
//
//  Created by people on 2016/11/7.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var baseGame: BaseGameModel? {
        didSet{
           titleLabel.text = baseGame?.tag_name
            
            if baseGame?.icon_url == "" {//“更多”
                iconImageView.image = UIImage(named: "home_more_btn")
                
            }else{
                let iconURL = URL(string: (baseGame?.icon_url)!)
                let resource = ImageResource.init(downloadURL: iconURL!)
                /*
                 这里Resource直接填iconURL也可以
                 iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
                 */
                iconImageView.kf.setImage(with: resource, placeholder: UIImage(named: "home_more_btn"))
                
            }
        }
    }
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

}
