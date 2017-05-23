//
//  BaseViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

let cellID = "cellID"

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorWithHexString(hex: "f0f1f2")
        
        // 初始化导航栏
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItems = [rightSecondBarButton,rightFirstBarButton]
    
    }
    
    // UITableview
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()
    
    // MARK:- 设置导航栏按钮的图片
    func setNavigationBarItemImage(barButton:UIBarButtonItem ,_ image:UIImage?) {
        guard let barButton:UIButton = barButton.customView as? UIButton else {
            AppLog("按钮不存在")
            return
        }
        barButton.setImage(image, for: .normal)
    }
    
    // 导航栏左边按钮
    lazy var leftBarButton:UIBarButtonItem = {
        let leftButton = UIButton()
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 38)
        leftButton.setImage(UIImage(named:"top_message_n"), for: .normal)
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 16)
        leftButton.addTarget(self, action: #selector(leftBarButtonClick), for: .touchUpInside)
        return UIBarButtonItem(customView: leftButton)
    }()
    
    // 右边第一个导航按钮点击
    lazy var rightFirstBarButton:UIBarButtonItem = {
        let barButton = UIButton()
        barButton.frame = CGRect(x: 0, y: 0, width: 30, height: 38)
        barButton.setImage(UIImage(named:"top_history_n"), for: .normal)
        barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 16, 0, -16)
        barButton.addTarget(self, action: #selector(rightFirstBarButtonClick), for: .touchUpInside)
        return UIBarButtonItem(customView: barButton)
    }()
    
    // 右边第二个导航按钮点击
    lazy var rightSecondBarButton:UIBarButtonItem = {
        let barButton = UIButton()
        barButton.frame = CGRect(x: 0, y: 0, width: 30, height: 38)
        barButton.setImage(UIImage(named:"top_download_n"), for: .normal)
        barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        barButton.addTarget(self, action: #selector(rightSecondBarButtonClick), for: .touchUpInside)
        return UIBarButtonItem(customView: barButton)
    }()
    

    // 左边导航按钮点击
    func leftBarButtonClick() {
        AppLog("")
    }
    
    // 右边第一个导航按钮点击
    func rightFirstBarButtonClick() {
        AppLog("")
    }
    
    // 右边第二个导航按钮点击
    func rightSecondBarButtonClick() {
        AppLog("")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    

}

extension BaseViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.backgroundColor = randomColor()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    
}
