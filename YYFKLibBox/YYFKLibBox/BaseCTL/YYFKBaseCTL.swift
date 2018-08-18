//
//  YYFKBaseCTL.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class YYFKBaseCTL: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func push(ctl:UIViewController) {
        ctl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctl, animated: true)
    }
    
    
    /// 设置图片rightBarButtonItem
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - action: Selector
    func setRightBarItem(image:UIImage ,action:Selector?) {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        btn.setBackgroundImage(image, for: .normal)
        if action != nil {
            btn.addTarget(self, action: action!, for: .touchUpInside)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    
    /// 设置文字rightBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - action: Selector
    func setRightBarItem(title:String ,action:Selector?,titleColor : UIColor?) {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: 70, height: 30)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.textAlignment = .right
        if action != nil {
            btn.addTarget(self, action: action!, for: .touchUpInside)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(titleColor, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    
    /// 设置titleView（image）
    ///
    /// - Parameter image: 图片
    func setTitleView(image:UIImage) {
        let imageView = UIImageView.init(image: image)
        self.navigationItem.titleView = imageView
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
