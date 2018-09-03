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
        view.delegate = self
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

// MARK: - 遵守协议
extension ZJHistoryRecordViewController : ZJCarouselViewDelegate {
    
    func zj_carouseView(_ carouseView: ZJCarouselView, didSelectedItemIndex didSectedIndex: NSInteger) {
        print("点击了第\(didSectedIndex)个")
    }
    
    func zj_carouseView(_ carouseView: ZJCarouselView, scrollTo scrollIndex: NSInteger) {
        print("滚动到第\(scrollIndex)个")
    }
}
