//
//  ZJImagePageControl.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/3.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJImagePageControl: UIPageControl {

    var kImageVW : CGFloat = 0
    var kImageVH : CGFloat = 0
    
    var kNormalImage : UIImage? = nil
    var kCurrentImage : UIImage? = nil
    // 圆角大小
    var kImageVCornerRadius : CGFloat? = 0
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
        let dotW :CGFloat = kImageVW != 0 ? kImageVW : 10
        
        // 圆点间距
        let margin : CGFloat = 0
        let marginX : CGFloat = dotW + margin
        
        //计算整个pageControll的宽度
        let pageW : CGFloat = CGFloat(self.subviews.count - 1 ) * marginX;
        
        //设置新frame
//        self.frame = CGRect(x:kScreenW/2 - (pageW + dotW)/2, y:self.frame.origin.y, width:pageW + dotW, height:self.frame.size.height)

        
        for view in self.subviews {
            
            var imageV = self.imageView(view: view)
            
            if imageV == nil {
                imageV = i==0 ? UIImageView(image: kCurrentImage) : UIImageView(image: kNormalImage)
            
                imageV!.center = view.center
                imageV?.frame = CGRect.init(x: CGFloat(i) * marginX - pageW/2, y: view.frame.origin.y+2, width: dotW, height: kImageVH != 0 ? kImageVH : 10)
                
                if kImageVCornerRadius! > CGFloat(0) {
                    imageV?.layer.cornerRadius = kImageVCornerRadius!
                    imageV?.layer.masksToBounds = true
                }
                
                view.addSubview(imageV!)
                
                view.clipsToBounds = false
                print(view.frame)
                
            }
            
            if i == self.currentPage {
                imageV!.image = kCurrentImage != nil ? kCurrentImage : UIImage(named: "homebusiness_Image_column_default")!
            } else {
                imageV!.image = kNormalImage != nil ? kNormalImage : UIImage(named: "link_select_icon_HL")!
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
