//
//  ZJImagePageControl.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/3.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJImagePageControl: UIPageControl {

    var kImageW : CGFloat = 10
    var kImageH : CGFloat = 10
    
    var kNormalImage = UIImage(named: "link_select_icon")
    var kCurrentImage = UIImage(named: "link_select_icon_HL")

    override var numberOfPages: Int {
        didSet{
            setUpImage()
        }
    }
    
    override var currentPage: Int{
        didSet{
            setUpImage()
        }
    }
    
    func setUpImage() {
        var i = 0
        
        for view in self.subviews {
            
            var imageV = self.imageView(view: view)
            
            if imageV == nil {
                imageV = i==0 ? UIImageView(image: kCurrentImage) : UIImageView(image: kNormalImage)
            
                imageV!.center = view.center
                imageV?.frame = CGRect.init(x: view.frame.origin.x, y: view.frame.origin.y+2, width: kImageW, height: kImageH)
                view.addSubview(imageV!)
                view.clipsToBounds = false
            }
            
            if i == self.currentPage {
                imageV!.image = kCurrentImage
            } else {
                imageV!.image = kNormalImage
            }
            
            i += 1
        }
        
    }
    
    private func imageView(view : UIView) -> UIImageView? {
        var dot : UIImageView?
        
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews{
                
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
        
    }

}
