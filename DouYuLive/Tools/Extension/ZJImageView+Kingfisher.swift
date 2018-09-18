//
//  ZJImageView+Kingfisher.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/31.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    public var sp : UIImageView{
        get { return self }
    }
    
    /// 1.加载网络图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片 URL地址
    ///   - placeholder: 占位图
    func zj_setImage(urlStr: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlStr) else {
            print("url:|\(urlStr)|无法解析为URL类型")
            if let placeholder = placeholder{
                self.image = placeholder
            }
            return
        }
        kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode], progressBlock: nil, completionHandler: nil)
    }
    
    /// 2.加载网络图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片地址
    ///   - placeholder: 占位图
    ///   - progresseCellBack: 加载进度
    ///   - completionHandler: 图片加载完毕完成回调
    func zj_setImageWithBlock(urlStr : String, placeholder: UIImage = UIImage(),progresseCellBack: DownloadProgressBlock? = nil,completionHandler: CompletionHandler?) {
        guard let url = URL(string: urlStr) else {
            print("url:|\(urlStr)|无法解析为URL类型")
            self.image = placeholder
            return
        }
        kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode], progressBlock: { (receivedSize, totalSize) in
            
            progresseCellBack?(receivedSize,totalSize)
        
        }, completionHandler: { (_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) in
        
            completionHandler?(image, error, cacheType, imageURL)
        
        })
        
    }
    
    

}
