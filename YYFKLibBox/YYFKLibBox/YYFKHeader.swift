//
//  YYFKHeader.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//



// 存储常量

let YYFScreenWidth : CGFloat                = UIScreen.main.bounds.size.width
let YYFScreenHeight : CGFloat               = UIScreen.main.bounds.size.height

let YYFSafeNavHeight : CGFloat              = (YYFScreenHeight  >= 812) ? 88.0 : 64.0
let YYFSafeBottomHeight : CGFloat           = (YYFScreenHeight  >= 812) ? 34.0 : 0.0
let YYFTabbarHeight : CGFloat               = YYFSafeBottomHeight + 49


// 统一存放Block定义
typealias CommonBlock                       = () -> ()
typealias CommonBlockInt                    = (Int) -> ()
typealias CommonBlockInt2                   = (Int,Int) -> ()
typealias CommonBlockStr                    = (String) -> ()
typealias CommonBlockStr2                   = (String,String) -> ()
typealias CommonBlockIntAndStr              = (Int,String) -> ()
typealias CommonBlockAny                    = (Any) -> ()
typealias CommonBlockJson                   = (JSON) ->()
typealias CommonBlockArr                    = ([Any]) -> ()

import UIKit

class YYFKHeader: NSObject {

}
