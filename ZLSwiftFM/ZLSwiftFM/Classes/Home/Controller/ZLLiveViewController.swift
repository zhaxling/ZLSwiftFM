//
//  ZLLiveViewController.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/18.
//  Copyright © 2017年 zl. All rights reserved.
//

import UIKit



let cellIDOfPlayList = "cellIDOfPlayList"
let cellIDOfRadios = "cellIDOfRadios"

class ZLLiveViewController: HomeBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(ZLRadiosTableViewCell.self , forCellReuseIdentifier: cellIDOfRadios)
        tableView.register(UINib.init(nibName: "ZLPlayListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIDOfPlayList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        // 加载数据
//        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    // private属性  类扩展中都不能访问
    lazy var viewModel:ZLLiveViewModel = {
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

// MARK:- 数据源代理
extension ZLLiveViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: cellIDOfRadios, for: indexPath) as! ZLRadiosTableViewCell
            
            cell.listTitleArray = ["开心","😊","不开心","😒"]
            
//            cell.backgroundColor  = UIColor.red
            cell.selectionStyle = .none
            
            
            return cell
        }
        else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: cellIDOfPlayList, for: indexPath) as! ZLPlayListTableViewCell
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowIn(indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.00001
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let  view  = ZLHomeHeaderView(frame: CGRect.zero)
            
            return view
        }else{
            return UIView()
        }
        
    }
}
