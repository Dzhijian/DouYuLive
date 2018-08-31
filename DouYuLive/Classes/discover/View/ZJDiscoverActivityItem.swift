//
//  ZJDiscoverActivityItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJDiscoverActivityItem: ZJBaseCollectionCell {
    private lazy var imgV : UIImageView = UIImageView()
    func configImgUrlStr(imgUrlStr : String){
        self.imgV.zj_setImage(urlStr: imgUrlStr)
//        self.imgV.kf.setImage(with: URL(string: imgUrlStr))
    }
    override func zj_initWithView() {
        self.imgV = UIImageView.zj_createImageView(imageName: "", supView: self.contentView, closure: { (make) in
            make.left.equalTo(Adapt(10))
            make.top.equalTo(Adapt(0))
            make.width.equalTo(Adapt(240))
            make.height.equalTo(Adapt(240*9/16))
        })
    }
}
