//
//  ZJCycleCardView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/20.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCycleCardView: ZJBaseView {

    private lazy var style : ZJCycleViewStyle = {
        let style = ZJCycleViewStyle()
        return style
    }()
    private lazy var imgArray : [String] = {
        let imgArr = [String]()
        return imgArr
    }()
    
    private var oldPointX : CGFloat?
    // item 总数
    private var itemCount : Int? = 0
    // 定时器
    private var autoTimer : Timer?
    private lazy var layout : ZJCycleCardViewFlowLayout = {
        let layout = ZJCycleCardViewFlowLayout()
        layout.isScale = self.style.kIsScaleView
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = kWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ZJBaseCollectionCell.self, forCellWithReuseIdentifier: ZJBaseCollectionCell.identifier())
        return collectionView
    }()
    init(frame : CGRect , imageArray : [String], style : ZJCycleViewStyle) {
        super.init(frame: frame)
        self.style = style
        self.imgArray = imageArray
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ZJCycleCardView {
    
    private func setUpTimer() {
        //设置一个定时器，每三秒钟滚动一次
        autoTimer = Timer.scheduledTimer(timeInterval: 3, target: self,
                                         selector: #selector(self.autoScrollAction),
                                         userInfo: nil, repeats: true)
        RunLoop.main.add(autoTimer!, forMode: RunLoopMode.commonModes)
    }
    
    
    @objc func autoScrollAction() {
        if itemCount == 0 {
            return
        }
        
        let currentIndex : Int = self.currentIndex()
        let targetIndex : Int = currentIndex + 1;
        
    }
    
    func currentIndex() -> Int {
        if(self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0){
            return 0;
        }
        var index : Int = 0;
        
        if (self.layout.scrollDirection == .horizontal) {//水平滑动
            index = Int((self.collectionView.contentOffset.x + (self.style.kItemWidth! + self.style.kItemMargin!) * 0.5) / (self.style.kItemMargin! + self.style.kItemWidth!));
        }else{
            index = Int((self.collectionView.contentOffset.y + self.layout.itemSize.height * 0.5) / self.layout.itemSize.height);
        }
        return max(0,index);
    }
    
    func scrollToIndex(index : Int) {
        if index >= self.itemCount! {
            if self.style.kIsInfiniteLoop! {
                let index = Int(itemCount! / 2)
                self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
            }
            
            return
        }
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// MARK: - 遵守协议
extension ZJCycleCardView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJBaseTableCell.identifier(), for: indexPath) as! ZJBaseCollectionCell
        
        return item
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.isUserInteractionEnabled = false
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.oldPointX = self.collectionView.contentOffset.x
        if self.style.kIsAutoScroll! {
            
        }
    }
    
    
    func invalidateTimer() {
        self.autoTimer?.invalidate()
        self.autoTimer = nil
    }
    
}

// 配置 UI 视图
extension ZJCycleCardView {

    private func setUpAllView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
