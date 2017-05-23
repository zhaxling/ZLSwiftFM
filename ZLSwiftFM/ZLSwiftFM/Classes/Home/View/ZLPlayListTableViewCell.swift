//
//  ZLPlayListTableViewCell.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/19.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

class ZLPlayListTableViewCell: UITableViewCell {
    
    ///左边 图标
    @IBOutlet weak var iconView: UIImageView!
    ///标题
    @IBOutlet weak var playCountLabel: UILabel!
    ///状态
    @IBOutlet weak var playStateLabel: UILabel!
    ///收听人数
    @IBOutlet weak var playTitleLabel: UILabel!
    
    var playColsure:(()->())? = nil
    

    
    @IBAction func playButtonClick(_ sender: Any) {
        
        /// 播放
        if self.playColsure != nil {
            self.playColsure!()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
