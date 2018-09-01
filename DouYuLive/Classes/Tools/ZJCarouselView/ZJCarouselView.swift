//
//  ZJCarouselView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


public enum pageControlPosition {
    case  center
    case  left
    case  right
}


class ZJCarouselView: UIView {
    
    /// 图片地址或名称
    var imageNamesOrURL : [String] = []{
        didSet{
            
            allItemsCount = isInfiniteLoop ? imageNamesOrURL.count * 100 : imageNamesOrURL.count
            
            // 图片大于一张允许滚动,小于一张禁止滚动
            collectionView.isScrollEnabled = imageNamesOrURL.count > 1 ? true : false
            
            // 刷新 collectionView
            collectionView.reloadData()
        }
    }
    
    /// 总数量
    private var allItemsCount: NSInteger! = 1
    
    
    /// 自动滚动 默认开启
    var isAutoScroll: Bool = true {
        didSet {
            invalidateTimer()
            // 如果关闭的无限循环，则不进行计时器的操作，否则每次滚动到最后一张就不在进行了。
            if isAutoScroll && isInfiniteLoop {
                setUpTimer()
            }
        }
    }
    
    /// 滚动间隔时间,默认2秒
    var autoScrollTimeInterval: Double = 2.0 {
        didSet {
            // 开启自动滚动
            isAutoScroll = true
        }
    }
    /// 最大伸展空间(防止出现问题，可外部设置),用于反方向滑动的时候，需要知道最大的contentSize
    private var maxSwipeSize: CGFloat = 0
    /// 占位图
    var placeHolderViewImage : UIImage! = UIImage(named: "")
    
    /// 总的 Item 个数
    var totalItemsCount: NSInteger! = 1
    
    // 是否开启无限循环,默认 true 开启
    var isInfiniteLoop : Bool = true {
        didSet{
            
        }
    }
    
    // 滚动方向,默认为水平方向
    var scrollDiretion : UICollectionViewScrollDirection? = .horizontal {
        didSet{
            
        }
    }
    
    /// Collection滚动方向
    var position : UICollectionViewScrollPosition = .centeredHorizontally
    
    /// 定时器
    private lazy var timer : DispatchSourceTimer? = {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + autoScrollTimeInterval, repeating: autoScrollTimeInterval)
        return timer
    }()
    
    /// UICollectionViewFlowLayout
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private let kIdentifier : String = "ZJCarouselCell"
    
    // UICollectionView
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(ZJCarouselCell.self, forCellWithReuseIdentifier:kIdentifier)
        return collectionView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 配置 UI 视图
extension ZJCarouselView {
    
    private func setUpAllView() {
        // 添加 UICollectionView
        self.addSubview(self.collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = self.bounds
        
        // 计算最大扩展区大小
        if scrollDiretion == .horizontal {
            maxSwipeSize = CGFloat(imageNamesOrURL.count) * collectionView.frame.width
        }else{
            maxSwipeSize = CGFloat(imageNamesOrURL.count) * collectionView.frame.height
        }
        
        // Cell Size
        layout.itemSize = self.frame.size
        
        if collectionView.contentOffset.x == 0 && totalItemsCount > 0 {
            var targetIndex = 0
            if isInfiniteLoop {
                targetIndex = totalItemsCount/2
            }
            collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: false)
        }
    }
}

// MARK: 定时器
extension ZJCarouselView {
    
    // 开启定时器
    private func setUpTimer() {
        
        // 图片小于一张不启动定时器
        guard self.imageNamesOrURL.count > 1  else { return }
        
        self.timer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.automaticScroll()
            }
        }
        
        // 开启定时器
        self.timer?.resume()
    }
    
    
    // 暂停定时器
    private func invalidateTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
    
}


// MARK: 事件处理
extension ZJCarouselView {
    
    /// 自动轮播
    @objc func automaticScroll() {
        if totalItemsCount == 0 {return}
        let targetIndex = currentIndex() + 1
        scrollToIndex(targetIndex: targetIndex)
    }
    
    
    // 获取当前的索引 index
    private func currentIndex() -> NSInteger {
        
        var index = 0
        
        if layout.scrollDirection == .horizontal {
            index = NSInteger(collectionView.contentOffset.x + layout.itemSize.width * 0.5) / NSInteger(layout.itemSize.width)
        }else{
            
            index = NSInteger(collectionView.contentOffset.y + layout.itemSize.width * 0.5) / NSInteger(layout.itemSize.height)
        }
        
        return index
    }
    
    /// 滚动到指定的位置
    /// targetIndex 指定的索引
    private func scrollToIndex(targetIndex : Int){
        if targetIndex >= allItemsCount {
            // 如果不开启自动滚动则直接返回不做操作
            guard isInfiniteLoop else {return}
            // 滚动到指定位置
            collectionView.scrollToItem(at: IndexPath(item: Int(totalItemsCount / 2), section: 0), at: position, animated: false)
        }
        
        collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: position, animated: true)
    }
    
    
    /// PageControl当前下标对应的Cell位置
    func pageControlIndexWithCurrentCellIndex(index: NSInteger) -> (Int) {
        return imageNamesOrURL.count == 0 ? 0 : Int(index % imageNamesOrURL.count)
    }
    
}

// MARK: - 遵守协议
extension ZJCarouselView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItemsCount == 0 ? 1 : allItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifier, for: indexPath) as! ZJCarouselCell
        // 获取当前索引
        let itemIndex = pageControlIndexWithCurrentCellIndex(index: indexPath.item)
        // 配置图片
        item.configImageNameOrUrl(imgNameOrURL: imageNamesOrURL[itemIndex])
        return item
    }
    
    // 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: UIScrollViewDelegate 滚动代理事件
extension ZJCarouselView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 图片少于一张直接返回
        guard imageNamesOrURL.count > 0 else { return }
        
        // 当前滚动到第几个
        let indexOnPageControl = pageControlIndexWithCurrentCellIndex(index: currentIndex())
        
        if scrollDiretion == .horizontal {
            var currentOffsetX = scrollView.contentOffset.x - (CGFloat(allItemsCount) * scrollView.frame.size.width) / 2
            
            if currentOffsetX < 0 {
                
                if currentOffsetX >= -scrollView.frame.size.width{
                    currentOffsetX = CGFloat(indexOnPageControl) * scrollView.frame.size.width
                }else if currentOffsetX <= -maxSwipeSize{
                    collectionView.scrollToItem(at: IndexPath(item: Int(allItemsCount/2), section: 0), at: position, animated: false)
                }else{
                     currentOffsetX = maxSwipeSize + currentOffsetX
                }
                
            }
            
            if currentOffsetX >= CGFloat(self.imageNamesOrURL.count) * scrollView.frame.size.width && isInfiniteLoop {
                collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
            }
            
        }else{
            
            var currentOffsetY = scrollView.contentOffset.y - (CGFloat(allItemsCount) * scrollView.frame.size.height) / 2
            
            if currentOffsetY < 0 {
                if currentOffsetY >= -scrollView.frame.size.height{
                    currentOffsetY = CGFloat(indexOnPageControl) * scrollView.frame.size.height
                }else if currentOffsetY <= -maxSwipeSize{
                    collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
                }else{
                    currentOffsetY = maxSwipeSize + currentOffsetY
                }
            }
            if currentOffsetY >= CGFloat(self.imageNamesOrURL.count) * scrollView.frame.size.height && isInfiniteLoop{
                collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
            }
        }
        
    }
    
    
    /// 开始拖动的时候关闭定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isAutoScroll {
            invalidateTimer()
        }
    }
    
    /// 结束拖动时候的事件
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard imageNamesOrURL.count > 0 else { return }
        
        // 开启定时器
        if isAutoScroll {
             setUpTimer()
        }
    }
    
    /// 自动滚动结束的时候调用的事件
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard imageNamesOrURL.count > 0 else { return }
        
        // 开启定时器
        if timer == nil && isAutoScroll {
            setUpTimer()
        }
    }
}
