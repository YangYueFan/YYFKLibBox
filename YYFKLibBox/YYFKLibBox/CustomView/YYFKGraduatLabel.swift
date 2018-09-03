//
//  YYFKGradualLabel.swift
//  GradualLabel
//
//  Created by 科技部iOS on 2018/9/3.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

typealias YYFKGraduatLabelBlock = (String)->()

class YYFKGraduatLabel: UIView {

    
    var tapBlock : YYFKGraduatLabelBlock?
    
    
    //控件
    var label : UILabel!
    var gradientLayer : CAGradientLayer?
    
    //文字相关
    var text = "" {
        didSet{
            self.label.text = text
        }
    }
    var textAlignment : NSTextAlignment = .left {
        didSet{
            self.label.textAlignment = textAlignment
        }
    }
    var textColor = UIColor.black {
        didSet{
            self.label.textColor = textColor
        }
    }
    var textFont : UIFont = UIFont.systemFont(ofSize: 15.0) {
        didSet{
            self.label.font = textFont
        }
    }
    var adjustsFontSizeToFitWidth = false {
        didSet{
            self.label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }
    }
    var numberOfLines : Int = 1 {
        didSet{
            self.label.numberOfLines = numberOfLines
        }
    }
    
    // 渐变颜色数组
    var colors : [CGColor]? {
        didSet{
            self.loadGraduatLayer()
        }
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel.init(frame: self.bounds)
        self.loadSetting()
        
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(tap(tapGR:)))
        self.addGestureRecognizer(tapGR)
    }
    
    @objc func tap(tapGR:UITapGestureRecognizer) {
        self.tapBlock?(self.text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化Label
    func loadSetting() {
        self.label.textAlignment = self.textAlignment
        self.label.textColor = self.textColor
        self.label.font = self.textFont
        self.label.numberOfLines = self.numberOfLines
        self.label.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth
    }
    
    //初始化GraduatLayer
    func loadGraduatLayer() {
        if self.gradientLayer != nil {
            self.gradientLayer!.removeFromSuperlayer()
        }else{
            self.gradientLayer = CAGradientLayer.init()
        }
        self.gradientLayer?.frame = self.bounds
        self.gradientLayer!.colors = self.colors
        self.gradientLayer!.startPoint = CGPoint.init(x: 0, y: 0.5)
        self.gradientLayer!.endPoint = CGPoint.init(x: 1, y: 0.5)
        self.layer.addSublayer(self.gradientLayer!)
        self.gradientLayer!.mask = self.label.layer
    }
    
    //自定义初始化YYFKGraduatLabel
    class func initLabel(frame:CGRect ,colors:[CGColor],text:String) -> YYFKGraduatLabel {
        let gradualLabel = YYFKGraduatLabel.init(frame: frame)
        gradualLabel.text = text
        gradualLabel.colors = colors

        return gradualLabel;
    }
    
    func runAnimation(startLoctions:[NSNumber],endLoctions:[NSNumber],duration:CFTimeInterval ,repeatCount:Float) {
        
        self.gradientLayer?.removeAnimation(forKey: "runAnimation")
        self.gradientLayer?.locations = startLoctions
        
        let animation = CABasicAnimation.init()
        animation.keyPath = "locations"
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.fromValue = startLoctions
        animation.toValue = endLoctions
        
        self.gradientLayer?.add(animation, forKey: "runAnimation")
    }

}
