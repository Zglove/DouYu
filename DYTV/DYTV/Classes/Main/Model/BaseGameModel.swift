//
//  BaseGameModel.swift
//  DYTV
//
//  Created by people on 2016/11/8.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    //MARK:- 定义属性
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() {}
    
    //MARK:- 自定义构造函数
    init(dict: [String: Any]){
        super.init()
        setValuesForKeys(dict)
    }
    //防止因解析不到key值而崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
