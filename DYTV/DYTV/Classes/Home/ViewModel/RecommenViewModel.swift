//
//  RecommenViewModel.swift
//  DYTV
//
//  Created by people on 2016/11/3.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

class RecommenViewModel {
    //MARK:- 懒加载属性
    fileprivate lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
    
}
//MARK:- 发送网络请求
extension RecommenViewModel {
    func requestData(){
    
        //-1.定义参数
        let parameters = ["limit":"4", "offset":"0","time": NSDate.getCurrentTime() as NSString]
        
        //0.创建Group
        let dGroup = DispatchGroup.init()
        
       //1.请求第一部分推荐数据
      
        //DispatchGroup.enter(dGroup)//进入组
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getDataRoom", parameters: ["time": NSDate.getCurrentTime() as NSString]) { (result) in
            
            //1.将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else {return}
            
            //2.根据data的key拿到数组,根据“data”拿到的是NSObject类型，需转成装着字典的数组类型
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}

            //3.遍历字典，转成模型对象
            //3.1 创建组
            let group = AnchorGroup()
            //3.2 设置组的属性
            group.tag_name = "热门"
            group.icon_name = "home_header_hot"
            //3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }

            
          //  DispatchGroup.leave(dGroup)//离开组
            print("请求道第 0 组数据")
        }
        
        
         //2.请求第二部分颜值数据
       // DispatchGroup.enter(dGroup)//进入组
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            
            //1.将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else {return}
            
            //2.根据data的key拿到数组,根据“data”拿到的是NSObject类型，需转成装着字典的数组类型
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            
            //3.遍历字典，转成模型对象
            //3.1 创建组
            let group = AnchorGroup()
            //3.2 设置组的属性
            group.tag_name = "颜值"
            group.icon_name = "home_header_phone"
            //3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
            
           // DispatchGroup.leave(dGroup)//离开组
            print("请求道第 1 组数据")
        }

        //3.请求后面2-12部分的游戏数据
       // DispatchGroup.enter(dGroup)//进入组
       //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1478151886
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
           
            /*
             1.将result转成字典类型
             as本身是将某个类型强转成另一个类型  as？:允许强转失败，返回nil  as:强制转换，开发者确定会有结果
            */
            guard let resultDic = result as? [String: NSObject] else {return}
            
            //2.根据data的key拿到数组,根据“data”拿到的是NSObject类型，需转成装着字典的数组类型
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            
            //3.遍历数组，获取字典，字典转模型,每一个字典是是一个 主播组 模型
            for dict in dataArray {
               let group = AnchorGroup(dict: dict)
                //下面两处的anchorGroups需要使用self，原因是当前代码处在闭包之中，所有在闭包中引用的属性都必须明确其拥有者是谁
                self.anchorGroups.append(group)
            }
            
            
          //  DispatchGroup.leave(dGroup)//离开组
         print("请求道 2-12 数据")
        }
        
        //4.所有数据都请求到之后进行排序
//        DispatchGroup.notify(dGroup, DispatchQueue.main()){
//            print("所有数据都请求道")
//        }
        
        
    }
}
