//
//  FunnyViewModel.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
private let kFuunyURL: String = "http://capi.douyucdn.cn/api/v1/getColumnRoom/3"

class FunnyViewModel: BaseViewModel {

    //MARK:- 定义属性
    
}
extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()){
       let parameters = ["limit":30,"offset":0]
       loadAnchorData(isGroupData: false, URLString: kFuunyURL, parameters: parameters, finishedCallback: finishedCallback)
    }
}
