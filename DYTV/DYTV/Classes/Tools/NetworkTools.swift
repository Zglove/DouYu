//
//  NetworkTools.swift
//  AlamofireTest
//
//  Created by people on 2016/11/3.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
   case GET
   case POST
}

class NetworkTools {

    //[String: NSString]  字典
    class func requestData(type: MethodType, URLString: String, parameters: [String: NSString]? = nil, finishedCallback: @escaping (_ result: AnyObject) -> ()) {
      //1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //2.发送网络请求
         Alamofire.request(URLString, method: method,parameters: parameters).responseJSON { (response) in
           //3.获取结果
            guard let rst = response.result.value else {
                print(response.result.error)
                return
            }
            //4.将结果回调出去
            finishedCallback(rst as AnyObject)
        }
        
    }
}
