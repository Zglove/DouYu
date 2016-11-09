//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by people on 2016/11/9.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit

private let kAmuseURL: String = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"

class AmuseViewModel: BaseViewModel {
   
}
extension AmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()){
      loadAnchorData(URLString: kAmuseURL, finishedCallback: finishedCallback)
    }
}
