//
//  PhotoPicker.swift
//  TodayNews
//
//  Created by ZXL on 2017/2/21.
//  Copyright © 2017年 zxl. All rights reserved.
//

import UIKit

class PhotoPicker: NSObject {
    
    static let share = PhotoPicker()
    
    // 闭包
    var result:((_ photos:Array<UIImage>) -> ())? = nil
    
    // 图片是否可以编辑
    var editEnable:Bool = true
    
    /// 选择照片
    func pick(result:@escaping (_ photos:Array<UIImage>) -> ()) {
        
        // 闭包
        self.result = result
        
        // 获得控制器
        let presentVC = getPresentVC()
        
        // 弹框
        let alertController = UIAlertController(title: "", message: "选择照片来源", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "相机", style: .default) { (action) in
            // 相机
            self.pickerController.sourceType = .camera
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                presentVC.present(self.pickerController, animated: true, completion: nil)
            }
        }
        
        let photoAction = UIAlertAction(title: "相册", style: .default) { (action) in
            // 相册
            self.pickerController.sourceType = .photoLibrary
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                presentVC.present(self.pickerController, animated: true, completion: nil)
            }
        }
        
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoAction)
        alertController.addAction(cancleAction)
        
        presentVC.present(alertController, animated: true) { 
            customLog("选择照片中")
        }
        
        
    }
    
    private func getPresentVC() -> UIViewController{
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
        let selectedNav = rootVC.selectedViewController as! UINavigationController
        return selectedNav.topViewController!
    }
    
    // 
    lazy var pickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        
        pickerController.allowsEditing = self.editEnable
        pickerController.delegate = self
        
        return pickerController
    }()

}

extension PhotoPicker: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    /// 取回图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type:String = info[UIImagePickerControllerMediaType] as! String
        // 选择的类型是图片
        var image:UIImage? = nil
        if type == "public.image" {
            if editEnable {
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            }
            else{
                image = info[UIImagePickerControllerOriginalImage] as? UIImage
            }
// MARK: 压缩方式
            let imageData = UIImageJPEGRepresentation(image!, 0.5)
            let img = UIImage(data: imageData!)
            if (result != nil) {
                result!([img!])
            }
        }
        
        // 退出
        pickerController.dismiss(animated: true) {
        }
    }
    
    /// 取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 退出
        pickerController.dismiss(animated: true) {
        }
        
    }
}
