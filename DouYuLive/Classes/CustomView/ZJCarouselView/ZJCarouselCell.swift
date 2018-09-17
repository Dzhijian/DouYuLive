//
//  ZJCarouselCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/2.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCarouselCell: UICollectionViewCell {
    
    private lazy var imgV : UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = UIColor.lightGray
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightText

        self.contentView.addSubview(imgV)
        imgV.frame = self.bounds

    }
    
    func configImageNameOrUrl(imgNameOrURL : String) {
        
        if imgNameOrURL.hasPrefix("http") {
            imgV.zj_setImage(urlStr: imgNameOrURL, placeholder: UIImage(named: ""))
        }else{
            imgV.image = UIImage(named: imgNameOrURL)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
