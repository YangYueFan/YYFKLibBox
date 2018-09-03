//
//  YYFKFunc.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

//封装的日志输出功能（T表示不指定日志信息参数类型）
func YYFLog<T>(_ message:T, file:String = #file, function:String = #function,
               line:Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName)_line\(line)_\(function) : \(message)")
    #endif
}

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
