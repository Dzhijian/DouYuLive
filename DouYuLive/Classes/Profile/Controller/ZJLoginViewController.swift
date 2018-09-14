//
//  ZJLoginViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/13.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJLoginViewController: ZJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "手机登录", style: .done, target: self, action: #selector(goBackAction))
    }

    @objc func goBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
