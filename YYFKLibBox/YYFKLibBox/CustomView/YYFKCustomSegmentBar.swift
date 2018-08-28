//
//  YYFKCustomSegmentBar.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/28.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

enum AnimatedType {
    case none
    case line1
    case line2
    case line3
}

enum ItemStyle {
    case line
    case block
    case blockRadius
}

protocol YYFKCustomSegmentBarDelegate {
    func segmentBar(bar:YYFKCustomSegmentBar ,selectIndex :Int)
}

typealias  CustomSegmentBarBlock = (Int) -> ()

class YYFKCustomSegmentBar: UIView ,UIScrollViewDelegate{

    //动画类型
    var animatedType : AnimatedType = .none
    var itemStyle : ItemStyle = .line
    
    //按钮宽度
    var itemWidth : CGFloat = 0.0
    
    var itemTintColor = UIColor.blue
    var itemDefaultColor = UIColor.lightGray
    var itemHeight : CGFloat = 0.0
    
    var items = [String]()
    
    var bgScrollView : UIScrollView!
    var currentIndex = 0
    
    var customSegmentBarBlock : CustomSegmentBarBlock?
    var delegate : YYFKCustomSegmentBarDelegate?
    
    //指示Line
    var segmentLine : UIView?
    
    class func initBar(_ frame:CGRect ,_ titleArr:[String], _ animatedType:AnimatedType , _ itemTintColor:UIColor? ,_ itemDefaultColor : UIColor? , _ itemWidth:CGFloat? ,_ itemStyle :ItemStyle?) -> YYFKCustomSegmentBar {
        
        let bar = YYFKCustomSegmentBar.init(frame: frame)
        bar.itemHeight = frame.height - 3.0
        if itemWidth != nil {
            bar.itemWidth = itemWidth!
        }
        if itemTintColor != nil {
            bar.itemTintColor = itemTintColor!
        }
        if itemDefaultColor != nil{
            bar.itemDefaultColor = itemDefaultColor!
        }
        if itemStyle != nil{
            bar.itemStyle = itemStyle!
        }
        bar.animatedType = animatedType
        bar.items = titleArr
        bar.loadItem()
        bar.backgroundColor = UIColor.withRGB(235, 235, 235)
        return bar
    }
    
    //初始化控件
    func loadItem() {
        
        if self.itemWidth == 0 {
            let w = YYFScreenWidth / CGFloat(items.count)
            self.itemWidth = w > 70 ? w : 70
        }

        self.bgScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height - 3))
        self.bgScrollView.backgroundColor = UIColor.white
        self.bgScrollView.bounces = false
        self.bgScrollView.delegate = self
        self.bgScrollView.showsVerticalScrollIndicator = false
        self.bgScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.bgScrollView)
        
        for (index,item) in self.items.enumerated() {
            let itemBtn = UIButton.init(type: .custom)
            itemBtn.frame = CGRect.init(x: CGFloat(index) * self.itemWidth,
                                        y: 0,
                                        width:  self.itemWidth,
                                        height: self.height-3)
            itemBtn.setTitle(item, for: UIControlState.normal)
            if self.itemStyle == .line {
                itemBtn.setTitleColor(self.itemTintColor, for: UIControlState.selected)
                itemBtn.setTitleColor(self.itemDefaultColor, for: UIControlState.normal)
            }else{
                itemBtn.setTitleColor(UIColor.white, for: UIControlState.selected)
                itemBtn.setTitleColor(self.itemDefaultColor, for: UIControlState.normal)
            }
            if index == 0 {
                itemBtn.isSelected = true
                self.currentIndex = 0
            }
            itemBtn.backgroundColor = UIColor.clear
            itemBtn.tag = index + 1
            itemBtn.addTarget(self, action: #selector(itemSelectAction(sender:)), for: .touchUpInside)
            self.bgScrollView.addSubview(itemBtn)
            self.bgScrollView.contentSize = CGSize.init(width: CGFloat(self.items.count) * self.itemWidth,
                                                        height: 0)
        }
        
        var lineHeight : CGFloat = 2
        if itemStyle != .line {
            lineHeight = self.height - (self.height / 10 * 3)
        }
        
        self.segmentLine = UIView.init(frame: CGRect.init(x: 2.5,
                                                          y: lineHeight == 2 ? self.height - 7 : 0,
                                                          width: self.itemWidth - 5,
                                                          height: lineHeight))
        self.segmentLine!.backgroundColor = self.itemTintColor
        self.bgScrollView.insertSubview(self.segmentLine!, at: 0)
        if itemStyle == .blockRadius {
            self.segmentLine!.cornerRadius = lineHeight * 0.5
        }
        if itemStyle != .line {
            self.segmentLine?.centerY = self.bgScrollView.centerY
        }
        
        
    }
    
    //点击按钮
    @objc func itemSelectAction(sender:UIButton) {
        
        let oldBtn = self.bgScrollView.viewWithTag(self.currentIndex+1) as! UIButton
        oldBtn.isSelected = false
        sender.isSelected = true
        self.currentIndex = sender.tag - 1
        
        if self.bgScrollView.contentSize.width > self.width {
            if sender.centerX > YYFScreenWidth/2 &&
                sender.centerX < self.bgScrollView.contentSize.width - YYFScreenWidth / 2 {
                self.bgScrollView.setContentOffset(CGPoint.init(x: sender.centerX - YYFScreenWidth / 2, y: 0), animated: true)
            }else if sender.centerX <= YYFScreenWidth/2{
                self.bgScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }else{
                self.bgScrollView.setContentOffset(CGPoint.init(x: self.bgScrollView.contentSize.width - self.width, y: 0), animated: true)
            }
        }
        
        
        if self.animatedType != .none {
            self.startAnimated(toBtn: sender)
        }else{
            self.segmentLine!.centerX = sender.centerX
        }
        
        //水波纹动画
        let transition = CATransition.init()
        transition.type = "rippleEffect"
        transition.subtype = "fromBottom"
        transition.duration = 1
        sender.layer.add(transition, forKey: nil)
        
        self.customSegmentBarBlock?(self.currentIndex)
        self.delegate?.segmentBar(bar: self, selectIndex: self.currentIndex)
        
    }

    //line动画
    func startAnimated(toBtn:UIButton) {
        
        if self.animatedType == .line1 {
            UIView.animate(withDuration: 0.25) {
                self.segmentLine!.centerX = toBtn.centerX
            }
        }else{
            if self.segmentLine!.rightX < toBtn.rightX {
                UIView.animate(withDuration: 0.25, animations: {
                    self.segmentLine!.width = toBtn.rightX - self.segmentLine!.left
                }) { (bool) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.segmentLine!.left = toBtn.left+2.5
                        self.segmentLine!.width = toBtn.width-5
                    })
                }
            }else if self.segmentLine!.rightX > toBtn.rightX {
                UIView.animate(withDuration: 0.25, animations: {
                    self.segmentLine!.width =  self.segmentLine!.rightX - toBtn.left
                    self.segmentLine!.left = toBtn.left+2.5
                }) { (bool) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.segmentLine!.width = toBtn.width-5
                    })
                }
            }
        }
    }
    
    
    //留给外面调用
    func selectItemIndex(index:Int) {
        let btn = self.bgScrollView.viewWithTag(index+1) as! UIButton
        self.itemSelectAction(sender: btn)
        
    }
    
    
    
    
    
}
