//
//  HomeViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //初始化UI
        setupUI()
    }
    
    // 标题
    let titles:[String] = ["直播","热门","分类","榜单","主播"]
    // 顶部标题
    var titleNavi:ZLCustomNavigation?
    /// 滚动的视图的滚动是否是因为用户点击了标题按钮
    var isScrollViewScrollByButtonClick:Bool = false

    func setupUI() {
        // 添加表格
        tableView.frame = CGRect(x: 0, y: 64 + kNavHeight, width: kScreenWidth, height: kScreenHeight - 64 - kNavHeight)
//        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        // 设置标题
        navigationItem.titleView = middleTitleView
        // 添加标题导航
        self.titleNavi = ZLCustomNavigation(frame: CGRect.zero,
                                           
                                            titles: titles) { [unowned self] (index) in
                                            AppLog( "点击了标题\(index)")
                self.isScrollViewScrollByButtonClick = true;
                self.scrollView.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(index), y: 0), animated: true)
        }
        view.addSubview(titleNavi!)
        scrollView.bringSubview(toFront: titleNavi!)
        
        // 添加滚动视图
        view.addSubview(scrollView)
    }

    // 搜索框
    lazy var middleTitleView:UIView = {
        let titleView = ZLTitleTextField()
        titleView.backgroundColor = UIColor.hexInt(0xebedf1)
        titleView.placeholder = "明清搜索拾遗"
        titleView.frame = CGRect(x: 0, y: 0, width: 236, height: 28)
        titleView.layer.cornerRadius = 14
        titleView.isEnabled = false
        titleView.clipsToBounds = true
        return titleView
    }()
    
    // 滚动视图
    lazy var scrollView:UIScrollView = {
    
        let scrollView = UIScrollView()
        
        scrollView.frame = CGRect(x: 0, y: 64 + kNavHeight, width: kScreenWidth, height: (kScreenHeight - 64 -  kNavHeight))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(self.titles.count), height: 0)
        
        // 添加View
        for (index, _) in self.titles.enumerated() {
            let viewController = self.subViewControllers[index]
            viewController.view.frame = CGRect(x: kScreenWidth * CGFloat(index), y: 0, width: kScreenWidth, height: (kScreenHeight - 64 - kNavHeight))
            scrollView.addSubview(viewController.view)
        }
        
        return scrollView
    }()

    private lazy var subViewControllers:[UIViewController] = {
        var array = [UIViewController]()
        
        // 直播
        let live = ZLLiveViewController()
        self.addChildViewController(live)
        array.append(live)
        // 热门
        let hot = ZLHotViewController()
        self.addChildViewController(hot)
        array.append(hot)
        // 分类
        let category = ZLCategoryViewController()
        self.addChildViewController(category)
        array.append(category)
        // 榜单
        let top = ZLTopsViewController()
        self.addChildViewController(top)
        array.append(top)
        // 主播
        let anchor = ZLAnchorViewController()
        self.addChildViewController(anchor)
        array.append(anchor)
        
        return array
    }()
    
}

//MARK:- UIScrollViewDelegate
extension HomeViewController {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        /// 滚动标题
        // 通过调用setContentOffset这个方法 该代理会有回调
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// 滚动标题
        let page = Int(scrollView.contentOffset.x / kScreenWidth + 0.5)
        AppLog(page)
        titleNavi?.setTitleIndex(index: page)
    }
}
