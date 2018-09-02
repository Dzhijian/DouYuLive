//
//  ZJHistoryRecordViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/2.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJHistoryRecordViewController: ZJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = ZJCarouselView(frame: CGRect(x: 0, y: 100, width: kScreenW, height: 200))
        view.imageNamesOrURL = ["liveImage","http://www.g-photography.net/file_picture/3/3587/4.jpg","liveImage"]
        self.view.addSubview(view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
       print("ZJHistoryRecordViewController 控制器销毁了")
    }

}
