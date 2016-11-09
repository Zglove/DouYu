//
//  RecommenViewModel.swift
//  DYTV
//
//  Created by people on 2016/11/3.
//  Copyright © 2016年 people2000. All rights reserved.
//
/*
 1>请求数据转化成模型对象
 2>对数据进行排序
 3>显示headerView中的数据
 */

import UIKit

private let kBigDataURL: String = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
private let kPrettyURL: String = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
private let kGameURL: String = "http://capi.douyucdn.cn/api/v1/getHotCate"

class RecommenViewModel: BaseViewModel {
    //MARK:- 懒加载属性
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
}
//MARK:- 发送网络请求
extension RecommenViewModel {
    
    //请求推荐数据
    func requestData(finishedCallback: @escaping () -> ()){
    
        //-1.定义参数
        let parameters = ["limit":"4", "offset":"0","time": Date.getCurrentTime() as NSString]
        
        //0.创建Group
        let dGroup = DispatchGroup()
        
       //1.请求第一部分推荐数据http://capi.douyucdn.cn/api/v1/getbigDataRoom
        dGroup.enter()//进入组
        
        NetworkTools.requestData(type: .GET, URLString: kBigDataURL, parameters: ["time": Date.getCurrentTime() as NSString]) { (result) in
            
            //1.将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else {return}
            
            //2.根据data的key拿到数组,根据“data”拿到的是NSObject类型，需转成装着字典的数组类型
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}

            //3.遍历字典，转成模型对象
                //3.1 创建组
              
                //3.2 设置组的属性
                self.bigDataGroup.tag_name = "热门"
                self.bigDataGroup.icon_name = "home_header_hot"
                //3.2 获取主播数据
                for dict in dataArray {
                    let anchor = AnchorModel(dict: dict)
                   self.bigDataGroup.anchors.append(anchor)
                }

        
            dGroup.leave()//离开组
           
        }
        
        
         //2.请求第二部分颜值数据
        dGroup.enter()//进入组
        NetworkTools.requestData(type: .GET, URLString: kPrettyURL, parameters: parameters) { (result) in
            
            
            //1.将result转成字典类型
            guard let resultDic = result as? [String: NSObject] else {return}
            
            //2.根据data的key拿到数组,根据“data”拿到的是NSObject类型，需转成装着字典的数组类型
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            
            //3.遍历字典，转成模型对象
                //3.1 创建组
               
                //3.2 设置组的属性
                self.prettyGroup.tag_name = "颜值"
                self.prettyGroup.icon_name = "home_header_phone"
                //3.2 获取主播数据
                for dict in dataArray {
                    let anchor = AnchorModel(dict: dict)
                    self.prettyGroup.anchors.append(anchor)
                }
                dGroup.leave()//离开组
           
        }

        //3.请求后面2-12部分的游戏数据
        dGroup.enter()//进入组
        loadAnchorData(URLString: kGameURL, parameters: parameters) {
            
            dGroup.leave()
        }
        
        
        //4.所有数据都请求到之后进行排序

        dGroup.notify(qos: DispatchQoS.background, flags: DispatchWorkItemFlags.assignCurrentContext, queue: DispatchQueue.main) {
        
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
           
            finishedCallback()
        }

    }
    
    //请求无线轮播的数据
    func requestCycleData(finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String: NSObject] else {return}
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            //3.字典转模型对象
            for dict in dataArray {
               self.cycleModels.append(CycleModel(dict: dict))
            }
            
            
            finishedCallback()
        }
    }
    
    
}
