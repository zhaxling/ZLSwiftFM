//
//  ZLTabBar.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/15.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

// tag的累积值
let kTagPlus: NSInteger = 100
// 分栏视图高度
let kTabBarH: CGFloat = 49

protocol ZLTabBarDelegate {
    func tabbarDidClickIndex(_ index:NSInteger)
}

class ZLTabBar: UIImageView {
    
    // 当前选择的按钮
    var selectedBtn:UIButton?
    
    // 代理
    var delegate:ZLTabBarDelegate?
    
    
    // 获取图片名称数组
    lazy var imagePrefixArray:[String] = {
        return ["tabbar_icon_homepage_",
                "tabbar_icon_Rss_",
                "tabbar_np_",
                "tabbar_icon_find_",
                "tabbar_icon_my_"]
    }()
    
    lazy var displayLink:CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(displayLinkEvent))
        displayLink.isPaused = true
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
        return displayLink
    }()
    

    override init(frame: CGRect) {
        // 设置frame
        let tabbarFrame = CGRect(x: 0, y: kScreenHeight - kTabBarH, width: kScreenWidth, height: kTabBarH)
        super.init(frame: tabbarFrame)
        
        // 添加shadow
        addSubview(shadowImageView)
        // 初始化
        isUserInteractionEnabled = true
        image = UIImage(named:"tabbar_bg")
        
        for index in 0..<5 {
            
            let btnW:CGFloat = tabbarFrame.width / 5
            
            if index == 2 {
                let btn = PlayButton(frame: CGRect(x: kScreenWidth * 0.5 - kTabBarH * 0.5, y: -10, width: kTabBarH + 10, height: kTabBarH + 10))
                btn.tag = kTagPlus + index
                addSubview(btn)
                btn.setImage(UIImage(named:imagePrefixArray[index] + "normal"), for: .normal)
                btn.setImage(UIImage(named:imagePrefixArray[index] + "normal"), for: .highlighted)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                
            }else{
                let btn = UIButton(type: .custom)
                btn.tag = kTagPlus + index
                addSubview(btn)
                btn.setImage(UIImage(named:imagePrefixArray[index] + "normal"), for: .normal)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                btn.frame = CGRect(x: btnW * CGFloat(index), y: 0, width: btnW, height: kTabBarH)
                btn.setImage(UIImage(named:imagePrefixArray[index] + "pressed"), for: .selected)
            }
        }
        
        // 设置中间按钮阴影
        guard let playBtn = viewWithTag(102) else {return}
        let img = UIImageView(image: UIImage(named: "tabbar_np_shadow"))
        let btnW: CGFloat = playBtn.frame.width + 4
        img.frame = CGRect(x: -2, y: -2, width: btnW, height: btnW * 13.0 / 15.0)
        playBtn.addSubview(img)
        
        // 默认选择第一个按钮
        btnClick(viewWithTag(kTagPlus) as! UIButton)
        selectedBtn = viewWithTag(kTagPlus) as? UIButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var shadowImageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: -0.5, width: kScreenWidth, height: 1))
        imageView.image = UIImage(named: "tabbar_bg_shadow")
//        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    // 按钮点击
    func btnClick(_ btn:UIButton) {
        AppLog(btn.tag)
        
        if btn.tag == 102 {
            // 如果在播放 隐藏播放图标按钮 开启CADisplayLink事件
            displayLink.isPaused = false
        }
        
        //切换控制器
        if btn.tag != 102 {
            delegate?.tabbarDidClickIndex(btn.tag)
            // 设置按钮状态
            selectedBtn?.isSelected = false
            btn.isSelected = true
            selectedBtn = btn
        }
    }
    
    func displayLinkEvent() {
        // 转动播放按钮
        guard let playButton:PlayButton = viewWithTag(102) as? PlayButton else {
            AppLog("没有播放按钮")
            return
        }
        
        
        UIView.animate(withDuration: 0.1) { 
            playButton.button.transform = playButton.button.transform.rotated(by: CGFloat(Double.pi / (4 * 90)))
        }
        
    }
}


// MARK:- 中间的播放按钮
class PlayButton: UIButton {
    
    var isPlay:Bool = false
    
    // 播放按钮 添加点击事件
    lazy var button:UIButton = {
        let btn = UIButton(type: .custom)
//        btn .setImage(UIImage(named:"tabbar_np_playshadow"), for: .normal)
        btn.setImage(UIImage(named: "rotate"), for: .normal)
        btn.frame = CGRect(x: 5, y: 5, width: kTabBarH, height: kTabBarH)
//        btn.addTarget(self, action: #selector(playButtonClick), for: .touchUpInside)
        btn.layer.cornerRadius = kTabBarH * 0.5
        btn.clipsToBounds = true
        btn.isEnabled = false
        btn.backgroundColor = randomColor()
        return btn
    }()
    
    // ▶️按钮
    lazy var play:UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named:"tabbar_np_play"), for: .normal)
        btn.frame = self.button.frame
        btn.isUserInteractionEnabled = true
        btn.isEnabled = false
//        btn.addTarget(self, action: #selector(playButtonClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        addSubview(play)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playButtonClick() {
        AppLog("")
        // 交给父视图 处理触发事件
    }
}
