//
//  String+Path.swift
//  ZLSwiftFM
//
//  Created by ZXL on 2017/5/17.
//  Copyright © 2017年 zl. All rights reserved.
//

import Foundation

extension String{
    
    /**
     应用沙盒结构分析
     1、应用程序包：包含了所有的资源文件和可执行文件
     
     2、Documents：保存应用运行时生成的需要持久化的数据，iTunes同步设备时会备份该目录
     
     3、tmp：保存应用运行时所需要的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行，系统也可能会清除该目录下的文件，iTunes不会同步备份该目录
     
     4、Library/Cache：保存应用运行时生成的需要持久化的数据，iTunes同步设备时不备份该目录。一般存放体积大、不需要备份的非重要数据
     
     5、Library/Preference：保存应用的所有偏好设置，IOS的Settings应用会在该目录中查找应用的设置信息。iTunes同步设备时会备份该目录
     */
    
    static func documentPath(with fileName:String) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let filePath = (paths.first)! + "/" + fileName
        
        return filePath
    }
    
    
    static func tempPath(with fileName:String) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let filePath = (paths.first)! + "/" + fileName
        
        return filePath
    }
    
    static func cachetPath(with fileName:String) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let filePath = (paths.first)! + "/" + fileName
        
        return filePath
    }
    
}
