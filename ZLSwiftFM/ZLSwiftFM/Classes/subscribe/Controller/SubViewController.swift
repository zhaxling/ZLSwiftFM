//
//  SubViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class SubViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "订阅"
        
        // 添加表格
        tableView.frame = CGRect(x: 0, y: 64.0, width: kScreenWidth, height: kScreenHeight - 64 - kNavHeight)
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
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
