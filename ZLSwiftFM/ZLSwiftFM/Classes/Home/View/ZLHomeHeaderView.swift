//
//  ZLHomeHeaderView.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/19.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class ZLHomeHeaderView: UIView {

    // 左边按钮
    lazy var addressButton:UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: WIDTH(13))
        btn.setImage(UIImage(named:"liveRadioCellPoint"), for: .normal)
        btn.setTitle("北京", for: .normal)
        return btn
    }()
    
    // 更多按钮
    lazy var moreButton:UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: WIDTH(13))
        btn.setImage(UIImage(named:"np_user_more"), for: .normal)
        btn.setTitle("更多", for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addressButton)
        addSubview(moreButton)
        backgroundColor = UIColor.white
        
        addressButton.snp.makeConstraints { [unowned self] (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).inset(8)
            make.size.equalTo(CGSize(width: 60, height: 21))
        }
        
        moreButton.snp.makeConstraints { [unowned self] (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).inset(8)
            make.size.equalTo(CGSize(width: 60, height: 21))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
