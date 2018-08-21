//
//  ZJCycleCardViewFlowLayout.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/20.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCycleCardViewFlowLayout: UICollectionViewFlowLayout {
    
    var isScale : Bool? = false
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrs = super.layoutAttributesForElements(in: rect)
        
        if (!self.isScale!){
            return attrs
        }
        
        // 2.计算整体的中心点的x值
        let centerX : CGFloat = (self.collectionView?.contentOffset.x)!  + (self.collectionView?.bounds.size.width)!  * 0.5
        
        // 3.修改一下attributes对象
        for (_, attr) in (attrs?.enumerated())! {
            // 3.1 计算每个cell的中心点距离
            let  distance = abs(attr.center.x - centerX)
//            print(distance)
            // 3.2 距离越大，缩放比越小，距离越小，缩放比越大
            let factor : CGFloat = 0.001;
            let scale : CGFloat = 1 / (1 + distance * factor);
            attr.transform = CGAffineTransform(scaleX: scale, y: scale);
        }
        
        return attrs
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
