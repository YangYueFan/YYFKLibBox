//
//  YYFKTabBarCTL.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class YYFKTabBarCTL: UITabBarController {

    
    var lastItemIndex = 0  //记录上一次点击tabbar
    var isAnimation = false
    
    /// 创建自定义TabbarCTL
    ///
    /// - Parameters:
    ///   - titles: [标题]
    ///   - defaultImages: [默认图片]
    ///   - vcNameStrs: vc(字符串类型)
    ///   - selectedImages: [选中图片]
    ///   - selectedIndex: 默认选择
    class func initYYFKTabBar(titles:[String],defaultImages:[UIImage],vcNameStrs:[String],selectedImages:[UIImage],selectedIndex:Int ,animation:Bool) -> YYFKTabBarCTL? {
        
        return YYFKTabBarCTL.initYYFKTabBar(titles: titles, defaultImages: defaultImages, vcList: YYFKFunc.strToVC(names: vcNameStrs), selectedImages: selectedImages, selectedIndex: selectedIndex ,animation:animation)
    }
    
    /// 创建自定义TabbarCTL
    ///
    /// - Parameters:
    ///   - titles: [标题]
    ///   - defaultImages: [默认图片]
    ///   - vcList: vc
    ///   - selectedImages: [选中图片]
    ///   - selectedIndex: 默认选择
    class func initYYFKTabBar(titles:[String],defaultImages:[UIImage],vcList:[UIViewController],selectedImages:[UIImage],selectedIndex:Int ,animation:Bool) -> YYFKTabBarCTL? {
        
        if titles.count < defaultImages.count ||
            titles.count < vcList.count ||
            titles.count < selectedImages.count ||
            titles.count < defaultImages.count{
            
            assertionFailure("错误 条件不满足")
            return nil
            
        }else if selectedIndex < 0 || selectedIndex >= titles.count {
            assertionFailure("错误 selectedIndex")
            return nil
        }
        
        let tabbarCTL = YYFKTabBarCTL()
        for index in 0..<titles.count {
            
            let ctl = vcList[index]
            let navCtl = UINavigationController.init(rootViewController: ctl)
            ctl.navigationItem.title = titles[index]
            let defaultImage = defaultImages[index].withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let selectedImage = selectedImages[index].withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let tabBarItem = UITabBarItem.init(title: titles[index],
                                               image: defaultImage,
                                               selectedImage: selectedImage)
            navCtl.tabBarItem = tabBarItem
            tabbarCTL.addChildViewController(navCtl)
        }
        tabbarCTL.selectedIndex = selectedIndex
        tabbarCTL.lastItemIndex = selectedIndex
        tabbarCTL.isAnimation = animation
        return tabbarCTL
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = false
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if isAnimation {
            let index = tabBar.items?.index(of: item)
            if  index != lastItemIndex {
                
                var itemArr = Array<AnyObject>()
                for view in tabBar.subviews {
                    if view.isKind(of: NSClassFromString("UITabBarButton")!){
                        itemArr.append(view)
                    }
                }
                //排序 原本顺序会有问题
                itemArr.sort(by: { (barBtn1, barBtn2) -> Bool in
                    return barBtn1.frame.origin.x < barBtn2.frame.origin.x
                })
                animation(layer:itemArr[index!])
            }
            lastItemIndex = index!
        }
    }
    
    func animation(layer:AnyObject) {
        
        DispatchQueue.main.async {
            let animation =  CABasicAnimation(keyPath: "transform.scale")
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.duration = 0.10
            animation.repeatCount = 1
            animation.autoreverses = true   //复原
            animation.fromValue = 1
            animation.toValue = 1.5
            
            let tabBarLayer = layer.layer
            tabBarLayer?.add(animation, forKey: nil)
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
