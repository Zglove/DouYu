//
//  AnchorGroup.swift
//  DYTV
//
//  Created by people on 2016/11/3.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组中对应的房间信息
    var room_list: [[String: NSObject]]? {
        //此方法监听该属性被赋值后
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
               self.anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    var tag_name: String = ""
    //组显示的图标
    var icon_name: String = "home_header_normal"
    //游戏对应的图标
    var icon_url: String = ""
    //定义主播的模型对象数组
     lazy var anchors: [AnchorModel] = [AnchorModel]()//懒加载的简写方式

    
    override init() {}
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    //防止因解析不到key值而崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String: NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
        }
    }
    */
}


