//
//  ZLLiveViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/18.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class ZLLiveViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        // 加载数据
//        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    private lazy var viewModel:ZLLiveViewModel = {
        let viewModel = ZLLiveViewModel()
        return viewModel
    }()
    
    override func loadData() {
        viewModel.refreshDataSource()
        viewModel.updateClosure = { [unowned self] in
            /// 更新列表数据
            self.tableView.reloadData()
        }
    }

}
