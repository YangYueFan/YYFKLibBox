//
//  FirstCTL.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/18.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class FirstCTL: YYFKTableViewCTL ,UITableViewDelegate,UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        let label = YYFKGraduatLabel.initLabel(frame: CGRect.init(x: 0, y: 100, width: 100, height: 35),
                                           colors: [UIColor.orange.cgColor,
                                                    UIColor.red.cgColor
                                                    ,UIColor.purple.cgColor],
                                           text: "这是测试文字")
        self.view.addSubview(label)
        label.tapBlock = { (text) in
            print(text)
        }
        label.runAnimation(startLoctions: [NSNumber.init(value: 0.0),
                                           NSNumber.init(value: 0.1),
                                           NSNumber.init(value: 1.0)],
                           endLoctions: [NSNumber.init(value: 0.9),
                                         NSNumber.init(value: 0.1),
                                         NSNumber.init(value: 0.0)],
                           duration: 3.0,
                           repeatCount: 9999)
        self.navigationItem.titleView = label
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier:  "Cell")
            
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.image = UIImage.init(named: "icon\(indexPath.row/2+1)")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.push(ctl: FirstCTL())
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
