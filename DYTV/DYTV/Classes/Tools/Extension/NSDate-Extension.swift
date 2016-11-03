//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by people on 2016/11/3.
//  Copyright © 2016年 people2000. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
       let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
