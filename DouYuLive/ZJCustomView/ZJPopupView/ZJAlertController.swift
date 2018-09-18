//
//  ZJAlertView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJAlertController {

    static func zj_showAlertView(currentController : UIViewController, title: String, message: String, confirmTitle: String, cancelTitle: String , confirmHandler:@escaping ((UIAlertAction) -> Void) , cancelHandel:@escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // 取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .default) { (action) in
            cancelHandel(action)
        }
        // 确定按钮
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandler(action)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        currentController.present(alert, animated: true, completion: nil)
        
    }
    
    static func zj_showSheetView(currentController : UIViewController, title: String, message: String, actionArray: [String], confirmTitle: String, cancelTitle: String , actionHandler:@escaping ((UIAlertAction) -> Void) , cancelHandel:@escaping ((UIAlertAction) -> Void)) {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        actionArray.forEach { (item) in
            let action = UIAlertAction(title: item, style: .default, handler: { (action) in
                actionHandler(action)
            })
            
            sheet.addAction(action)
        }        // 取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelHandel(action)
        }
        sheet.addAction(cancel)
        
        currentController.present(sheet, animated: true, completion: nil)
        
    }
}
