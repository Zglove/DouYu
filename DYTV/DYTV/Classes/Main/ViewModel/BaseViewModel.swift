//
//  BaseViewModel.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class BaseViewModel {
    //MARK:- 懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}
extension BaseViewModel {
    func loadAnchorData(isGroupData: Bool = true, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters) { (result) in
           
            /*
             1.将result转成字典类型
             as本身是将某个类型强转成另一个类型  as？:允许强转失败，返回nil  as:强制转换，开发者确定会有结果
             */
            guard let resultDict = result as? [String: Any] else { return }
            
            //根据data的key拿到数组,根据“data”拿到的是Any类型，需转成装着字典的数组类型
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            
            //2.判断是否是分组数据
            if isGroupData == true {
                //2.1遍历数组，获取字典，字典转模型,每一个字典是是一个 主播组 模型
                for dict in dataArray {
                    //当前代码处在闭包之中，所有在闭包中引用的属性都必须明确其拥有者是谁
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else {
                //2.2自己创建一个组用来装主播模型数据
                let group = AnchorGroup()
                for dict in dataArray {
                    
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            //3.回调
            finishedCallback()
        }
    }
}
