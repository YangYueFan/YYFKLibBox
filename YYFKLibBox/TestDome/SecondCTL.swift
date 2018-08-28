//
//  SecondCTL.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class SecondCTL: YYFKTableViewCTL {

    var pageCtl : YYFKPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.pageCtl == nil {
            self.pageCtl = YYFKPageControl.initPageControl(rect: CGRect.init(x: 0, y: 0, width: YYFScreenWidth, height: YYFScreenHeight - YYFSafeNavHeight - YYFTabbarHeight), titleArr: ["信息","好友"], contentVCArr: [FirstCTL(),FirstCTL()], currentPage: 0)
            self.view.addSubview(self.pageCtl!)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
