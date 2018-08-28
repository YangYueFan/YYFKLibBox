//
//  ThirdCTL.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/28.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class ThirdCTL: YYFKBaseCTL {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bar = YYFKCustomSegmentBar.initBar(CGRect.init(x: 0, y: YYFSafeNavHeight, width: YYFScreenWidth, height: 50), ["A","B","C","D","E","F","G",], .line1, UIColor.withHex(hexString: "#4876FF"), UIColor.withHex(hexString: "#A3A3A3"), nil ,nil)
        self.view.addSubview(bar)
        
        let bar1 = YYFKCustomSegmentBar.initBar(CGRect.init(x: 0, y: YYFSafeNavHeight + 100, width: YYFScreenWidth, height: 50), ["A","B","C","D","E","F","G",], .line1, UIColor.withHex(hexString: "#4876FF"), UIColor.withHex(hexString: "#A3A3A3"), nil ,.block)
        self.view.addSubview(bar1)
        
        let bar2 = YYFKCustomSegmentBar.initBar(CGRect.init(x: 0, y: YYFSafeNavHeight + 200, width: YYFScreenWidth, height: 50), ["A","B","C","D","E","F","G",], .line2, UIColor.withHex(hexString: "#4876FF"), UIColor.withHex(hexString: "#A3A3A3"), nil ,.blockRadius)
        self.view.addSubview(bar2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
