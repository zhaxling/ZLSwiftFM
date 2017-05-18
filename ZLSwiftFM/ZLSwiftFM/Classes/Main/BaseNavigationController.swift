//
//  BaseNavigationController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        navigationBar.tintColor = UIColor.orange
        navigationBar.backgroundColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(named:"navigationbar_bg_64"), for: .default)
        
        let attributes = [
            NSForegroundColorAttributeName : UIColor.hexInt(0x333333),
            NSFontAttributeName: UIFont.systemFont(ofSize: 18)
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
//        UINavigationBar.appearance().tintColor = UIColor.hexInt(0x333333)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
