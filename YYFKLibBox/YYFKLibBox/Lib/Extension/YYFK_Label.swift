//
//  YYFK_Label.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/9/1.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit



extension UILabel {

    
    
    /// 设置渐变字
    ///
    /// - Parameters:
    ///   - text: 字
    ///   - colors: 渐变颜色
    ///   - startPoint: 开始点
    ///   - endPoint: 结束点
    func setGradualText(text:String,colors:[CGColor],startPoint:CGPoint,endPoint:CGPoint) {
        self.text = text
        self.sizeToFit()
        let gradualLayer = CAGradientLayer()
        gradualLayer.frame = self.frame
        gradualLayer.colors = colors
        gradualLayer.startPoint = startPoint
        gradualLayer.endPoint = endPoint
        self.superview!.layer.addSublayer(gradualLayer)
        gradualLayer.mask = self.layer
        self.frame = gradualLayer.bounds
        
    }
    
}


class YYFK_Label: UILabel {

}
