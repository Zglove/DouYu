//
//  UIColor-Extension.swift
//  DYTV
//
//  Created by people on 2016/10/31.
//  Copyright © 2016年 people2000. All rights reserved.
//

import UIKit
extension UIColor{

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
