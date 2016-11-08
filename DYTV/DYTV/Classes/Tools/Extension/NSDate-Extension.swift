//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by people on 2016/11/3.
//  Copyright © 2016年 people2000. All rights reserved.
//

import Foundation

extension Date {
    //Date在swift3.0中是结构体，不是类不能用class（只能在类中修饰），非类中可用static修饰
    static func getCurrentTime() -> String {
       let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
