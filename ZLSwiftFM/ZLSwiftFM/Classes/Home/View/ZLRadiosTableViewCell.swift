//
//  ZLRadiosTableViewCell.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/19.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit

let collectionCellID:String = "cellID"


class ZLRadiosTableViewCell: UITableViewCell {
    
    let titles = ["本地台","国家台","省市台","网络台"]
    let icons = ["icon_radio_local", "icon_radio_country", "icon_radio_province", "icon_radio_internet"]
    
    var listTitles:[String]?
    var listTitleArray:[String]? {
        set {
            self.listTitles = newValue
            self.collectionView.reloadData()
        }
        
        get {
            return self.listTitles
        }
    }
    // 是否显示更多
    var isShowMore:Bool = false
    
    

    lazy var iconListView:ZLIconListView = {
        let view = ZLIconListView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: 90), titles: self.titles, icons: self.icons)
        
        return view
    }()
    
    lazy var collectionView:UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 80, height: 38)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "ZLRadioCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: collectionCellID)
        
        return collectionView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconListView)
        addSubview(collectionView)
        
        iconListView.snp.makeConstraints { [unowned self] (make) in
            make.top.equalTo(self).inset(10)
            make.left.right.equalTo(self)
            make.height.equalTo(90)
        }
        
        collectionView.snp.makeConstraints {[unowned self]  (make) in
            make.top.equalTo(self.iconListView.snp.bottom)
            make.left.right.equalTo(self).inset(18)
            make.height.equalTo(90)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 数据源代理
extension ZLRadiosTableViewCell :UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = (self.isShowMore || (self.listTitles?.count)! <= 8) ? (self.listTitles?.count)! : 8
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! ZLRadioCollectionViewCell
        
        
        cell.backgroundColor = UIColor.colorWithHexString(hex: "f6f6f6")
        
        if (self.listTitles?.count)! > 0 {
            cell.titleLabel.text = self.listTitles?[indexPath.row]
        }

        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        customLog("")
    }
}
