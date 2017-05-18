//
//  MyViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的"
        
        // 添加表格
        tableView.frame = CGRect(x: 0, y: 64.0, width: kScreenWidth, height: kScreenHeight - 64 - kNavHeight)
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
    }

   

}
