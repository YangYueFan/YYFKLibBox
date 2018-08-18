//
//  YYFKFunc.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit


class YYFKFunc: NSObject {
    
    
    /// String数组转VC
    ///
    /// - Parameter names: String数组
    /// - Returns: [vc]
    class func strToVC(names:[String]) -> [UIViewController] {
        var vcList = [UIViewController]()
        for name in names {
            vcList.append(YYFKFunc.strToVC(name: name))
        }
        return vcList
    }
    
    /// String转VC
    ///
    /// - Parameter names: String
    /// - Returns: [vc]
    class func strToVC(name:String) -> UIViewController {
        var className = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String//这是获取项目的名称，
        className = className + "." + name
        let vcType = NSClassFromString(className)! as! UIViewController.Type //这里需要指定类的类型XX.Type
        
        return vcType.init()
    }
    
}
