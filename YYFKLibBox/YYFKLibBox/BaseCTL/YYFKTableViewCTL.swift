//
//  YYFKTabelViewCTL.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class YYFKTableViewCTL: YYFKBaseCTL {

    var myTableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.initMyTableView()
        
    }
    
    func initMyTableView() {
        
        let rect = self.view.bounds
        self.myTableView = UITableView.init(frame: rect,
                                            style: UITableViewStyle.plain)
        self.view.addSubview(self.myTableView)
        self.myTableView.estimatedRowHeight = 0
        self.myTableView.estimatedSectionFooterHeight = 0
        self.myTableView.estimatedSectionHeaderHeight = 0
        self.myTableView.tableFooterView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //在有TabbarCTL的时候  高度有误  所以要重新设置Rect
        self.myTableView.frame = self.view.bounds
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
