//
//  HomeBaseViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/18.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class HomeBaseViewController: BaseViewController {
    
    // 当前加载的数据序号
    var currentPage:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = randomColor()
        
        // 初始化
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 加载数据
        loadData()
    }
    
    func setupUI() {
        // 添加表格
        tableView.frame = CGRect(x: 0, y: 0.0, width: kScreenWidth, height: kScreenHeight - 64 - kNavHeight)
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 200
        automaticallyAdjustsScrollViewInsets = false
    }
    
    func loadData() {
        
    }

   

}
