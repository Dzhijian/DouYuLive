//
//  ZJCycleCardView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/20.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

protocol ZJCycleCardViewDelegate {
    
    func zj_cycleCardViewDidSeletedItemAction(cycleCardView : ZJCycleCardView , index : Int )
}

class ZJCycleCardView: ZJBaseView {

    var delegate : ZJCycleCardViewDelegate?
    
    private lazy var style : ZJCycleViewStyle = {
        let style = ZJCycleViewStyle()
        return style
    }()
    
    // 图片数组
    private lazy var imgArray : [String] = {
        let imgArr  = [String]()
        return imgArr
    }()
    
    // 旧的点
    private var oldPointX : CGFloat?
    // item 总数
    private var itemCount : Int? = 0
    // 定时器
    private var autoTimer : Timer?
    // 记录左滑或者右滑
    private var _dragDirection : Int? = 0
    // 当前页
    private var currentpage : Int? = 0
    private lazy var layout : ZJCycleCardViewFlowLayout = {
        let layout = ZJCycleCardViewFlowLayout()
        layout.isScale = self.style.kIsScaleView
        layout.scrollDirection = .horizontal
        return layout
    }()
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = kWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ZJCycleCardItem.self, forCellWithReuseIdentifier: ZJCycleCardItem.identifier())
        return collectionView
    }()
    
    
    private lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    init(frame : CGRect , imageArray : [String], style : ZJCycleViewStyle) {
        super.init(frame: frame)
        self.style = style
        self.imgArray = imageArray
        addSubview(collectionView)
        setUpImgArr()
        
    }
    
    func setUpImgArr() {
        itemCount = self.style.kIsInfiniteLoop! ? imgArray.count * 100 : imgArray.count
        if imgArray.count > 1 {
            self.collectionView.isScrollEnabled = true
            self.setAutoScroll(autoScroll: self.style.kIsAutoScroll!)
        }else{
            self.collectionView.isScrollEnabled = false
            self.invalidateTimer()
        }
        
        self.collectionView.reloadData()
    }
    func setAutoScroll(autoScroll : Bool) {
        if self.style.kIsInfiniteLoop! {
            self.style.kIsAutoScroll = autoScroll
            
            self.invalidateTimer()
            if self.style.kIsAutoScroll!{
                self.setUpTimer()
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
        self.layout.itemSize = CGSize(width: self.style.kItemWidth!, height: self.bounds.size.height)
        self.layout.minimumLineSpacing = self.style.kItemMargin!
        self.layout.isScale = self.style.kIsScaleView!
        if self.collectionView.contentOffset.x == 0 && self.itemCount! > 0{
            var targetIndex : Int = 0
            targetIndex = self.style.kIsInfiniteLoop! ? itemCount! / 2 : 0
            
            self.collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .centeredHorizontally, animated: false)
                
            self.oldPointX = self.collectionView.contentOffset.x
            
            self.collectionView.isUserInteractionEnabled = true
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ZJCycleCardView {
    
    private func setUpTimer() {
        //设置一个定时器，每三秒钟滚动一次
        autoTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.style.autoScrollTimeInterval!), target: self,
                                         selector: #selector(self.autoScrollAction),
                                         userInfo: nil, repeats: true)
        RunLoop.main.add(autoTimer!, forMode: RunLoopMode.commonModes)
    }
    
    // 自动滚动
    @objc func autoScrollAction() {
        if itemCount == 0 {
            return
        }
        
        let currentIndex : Int = self.currentIndex()
        let targetIndex : Int = currentIndex + 1;
        self.scrollToIndex(index: targetIndex)
    }
    
    // 获取当前Item的索引
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
    
    // 滚动到第几个
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
    
    
    // 暂停销毁定时器
    func invalidateTimer() {
        self.autoTimer?.invalidate()
        self.autoTimer = nil
    }
}

// MARK: - 遵守协议
extension ZJCycleCardView : UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemCount!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJCycleCardItem.identifier(), for: indexPath) as! ZJCycleCardItem
        item.imgView.contentMode = self.style.ImageContentMode!
        item.imgView.image = UIImage(named: "liveImage");
        item.cornerRadius = self.style.imgCornerRadius!
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.zj_cycleCardViewDidSeletedItemAction(cycleCardView: self, index: self.currentIndex() % self.imgArray.count)
        
    }
    
    
    // 滚动时禁止点击 cell
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.isUserInteractionEnabled = false
    }
    
    // 开始拖动的时候关闭定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.oldPointX = self.collectionView.contentOffset.x
        if self.style.kIsAutoScroll! {
            self.invalidateTimer()
        }
        
    }
    
    // 结束拖动的时候开启定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if (self.style.kIsAutoScroll!) {
            self.setUpTimer()
        }
    }
    
    // 结束滚动时开启点击事件
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.scrollViewDidEndScrollingAnimation(self.collectionView)
    }
    
    // 结束滚动时开启点击事件
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        self.collectionView.isUserInteractionEnabled = true;
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(!self.style.kIsInfiniteLoop!) {return}//如果不是无限轮播，则返回
        
        //如果是向右滑或者滑动距离大于item的一半，则像右移动一个item+space的距离，反之向左
        let currentPoint : CGFloat = scrollView.contentOffset.x;
        let moveWidth : CGFloat = currentPoint - oldPointX!;
        let shouldPage : Int = Int(moveWidth / (self.style.kItemWidth! / 2));
        if (velocity.x>0 || shouldPage > 0) {
            _dragDirection = 1;
        }else if (velocity.x<0 || shouldPage < 0){
            _dragDirection = -1;
        }else{
            _dragDirection = 0;
        }
        self.collectionView.isUserInteractionEnabled = false;
        //
        let currentIndex : Int = Int((self.oldPointX! + (self.style.kItemWidth! + self.style.kItemMargin!) * 0.5) / (self.style.kItemMargin! + self.style.kItemWidth!))
        
        self.collectionView.scrollToItem(at: IndexPath(item: currentIndex + _dragDirection!, section: 0), at: .centeredHorizontally, animated: true)
        
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        //松开手指滑动开始减速的时候，设置滑动动画
        let currentIndex : Int = Int((oldPointX! + (self.style.kItemWidth! + self.style.kItemMargin!) / 2) / (self.style.kItemMargin! + self.style.kItemWidth!));
        self.collectionView.scrollToItem(at: IndexPath(item: currentIndex + _dragDirection!, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// 配置 UI 视图
extension ZJCycleCardView {

    private func setUpAllView() {
        addSubview(collectionView)
//        collectionView.snp.makeConstraints { (make) in
//            make.edges.equalTo(0)
//        }
    }
}
