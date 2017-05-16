//
//  BaseTabBarController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController,ZLTabBarDelegate {
    
    // 自定义分栏
    var tabBarView: ZLTabBar = {
        let tabBarView = ZLTabBar(frame: CGRect.zero)
        return tabBarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置tintColor
        //UITabBar.appearance().tintColor = UIColor.black
        
        // 添加分栏视图
        tabBar.isHidden = true
        tabBarView.delegate = self;
        view.addSubview(tabBarView)
        
        // 初始化子控制器
        configViewControllers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    func configViewControllers() {
        // 首页
        let homeVC = BaseNavigationController(rootViewController: HomeViewController())
        addChildViewController(homeVC)
        // 订阅
        let subscribeVC = BaseNavigationController(rootViewController: SubViewController())
        addChildViewController(subscribeVC)
        // 发现
        let findVC = BaseNavigationController(rootViewController: FindViewController())
        addChildViewController(findVC)
        // 我的
        let myVC = BaseNavigationController(rootViewController: MyViewController())
        addChildViewController(myVC)
    }

    // MARK:- 分栏点击代理ZLTabBarDelegate
    func tabbarDidClickIndex(_ index: NSInteger) {
        AppLog(index)
        
        var selectToIndex = index
        
        if (selectToIndex > kTagPlus + 2) {
            selectToIndex -= 1
        }
        self.selectedIndex = selectToIndex - kTagPlus
    }

}


