//
//  YYFKPageControl.swift
//  YYFKLibBox
//
//  Created by 科技部iOS on 2018/8/28.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit



class YYFKPageControl: UIView ,UIScrollViewDelegate,YYFKCustomSegmentBarDelegate{
    
    
    
    var bgScrollView : UIScrollView!
    var contentScrollView : UIScrollView!
    
    var titleArr = [String]()
    var scrollY : CGFloat = 0
    var contentVCArr = [UIViewController]()

//    var segmentBar : LKSegmentItemBar!
    var segmentBar : YYFKCustomSegmentBar!
    var currentPage = 0
    
    var kMenuHight:CGFloat = 50

    var barColor : UIColor! = UIColor.cyan {
        didSet{
            self.segmentBar.tintColor = self.barColor!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func initPageControl(titleArr:[String] ,contentVCArr:[UIViewController] ,currentPage:Int ) -> YYFKPageControl {
        
        let pageCtl = YYFKPageControl.init(frame: CGRect.init(x: 0, y: YYFSafeNavHeight, width: YYFScreenWidth, height: YYFScreenHeight - YYFSafeNavHeight))
        pageCtl.titleArr = titleArr
        pageCtl.currentPage = currentPage
        pageCtl.contentVCArr = contentVCArr
        pageCtl.loadBackgroundScrollView()
        
        return pageCtl
    }
    
    class func initPageControl(rect:CGRect, titleArr:[String] ,contentVCArr:[UIViewController] ,currentPage:Int ) -> YYFKPageControl {
        
        let pageCtl = YYFKPageControl.init(frame: rect)
        pageCtl.titleArr = titleArr
        pageCtl.currentPage = currentPage
        pageCtl.contentVCArr = contentVCArr
        pageCtl.loadBackgroundScrollView()

        return pageCtl
    }

    
    func loadBackgroundScrollView() {

        
        self.bgScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: YYFSafeNavHeight, width: self.width, height: self.height))
        self.bgScrollView.isPagingEnabled = true
        self.bgScrollView.bounces = false
        self.bgScrollView.delegate = self
        self.bgScrollView.backgroundColor = UIColor.withRGBA(235, 235, 235, 1)
        
        self.loadSegmentBar()
        
        
        let rect = CGRect.init(x: 0, y: self.kMenuHight  , width: self.width, height: self.height-self.kMenuHight)
        self.contentScrollView = UIScrollView.init(frame: rect)
        self.contentScrollView.isPagingEnabled = true
        self.contentScrollView.bounces = false
        self.contentScrollView.delegate = self
        
        for (index,vc) in contentVCArr.enumerated(){
            vc.view.frame = CGRect.init(x: CGFloat(index) * self.width, y: 0, width: self.width, height: self.height-self.kMenuHight)
            self.contentScrollView.addSubview(vc.view)
        }
        
        
        self.contentScrollView.addSubview(contentVCArr[0].view)
        self.contentScrollView.contentSize = CGSize.init(width: YYFScreenWidth*CGFloat(self.titleArr.count), height: self.height-self.kMenuHight)
        
        self.bgScrollView.addSubview(self.contentScrollView)
        self.bgScrollView.contentSize = CGSize.init(width: YYFScreenWidth, height: self.height )
        self.addSubview(self.bgScrollView)
    
    }
    
    func loadHeaderMeanView(headerView:UIView) {
        if headerView.height == 0 {
            return
        }else{
            headerView.left = 0
            headerView.width = self.width
            self.bgScrollView.addSubview(headerView)
        }
    }
    
    func loadSegmentBar() {

        self.segmentBar = YYFKCustomSegmentBar.initBar(CGRect.init(x: 0, y: 0, width: YYFScreenWidth, height: self.kMenuHight), self.titleArr, .line1, UIColor.withHex(hexString: "#4876FF"), UIColor.withHex(hexString: "#A3A3A3"), nil ,nil)
        self.segmentBar.delegate = self
        self.segmentBar.customSegmentBarBlock = { (index) in
            self.contentScrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*self.width, y: 0), animated: true)
        }
        self.bgScrollView.addSubview(self.segmentBar)
    }
    
    
    func segmentBar(bar: YYFKCustomSegmentBar, selectIndex: Int) {
        self.contentScrollView.setContentOffset(CGPoint.init(x: CGFloat(selectIndex)*YYFScreenWidth,
                                                             y: self.contentScrollView.contentOffset.y),
                                                animated: true)
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.contentScrollView {
            self.currentPage = Int(self.contentScrollView.contentOffset.x/self.contentScrollView.width)
            self.segmentBar.selectItemIndex(index: self.currentPage)
        }else{
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.bgScrollView {
            print("self.bgScrollView")
        }else{
            print("contentScrollView")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.contentScrollView {
            self.segmentBar.segmentLine?.left = scrollView.contentOffset.x/CGFloat(self.segmentBar.items.count)
        }
    }

}
