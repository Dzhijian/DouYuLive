//
//  ZJCarouselView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


public enum ZJPageControlPosition {
    case  center
    case  left
    case  right
}

/// Style
public enum ZJPageControlStyle {
    case none
    case system
    case image

}

@objc protocol ZJCarouselViewDelegate {
    /// 选中事件
    @objc optional func zj_carouseView(_ carouseView : ZJCarouselView, didSelectedItemIndex didSectedIndex :NSInteger)
    /// 滚动事件
    @objc optional func zj_carouseView(_ carouseView : ZJCarouselView,scrollTo scrollIndex: NSInteger)
}

class ZJCarouselView: UIView {
    
    
    /// 图片地址或名称
    var imageNamesOrURL : [String] = []{
        didSet{
            
            allItemsCount = isInfiniteLoop ? imageNamesOrURL.count * 100 : imageNamesOrURL.count
            
            // 图片大于一张允许滚动,小于一张禁止滚动
            collectionView.isScrollEnabled = imageNamesOrURL.count > 1 ? true : false
            
            if imageNamesOrURL.count <= 1 {
                invalidateTimer()
            }
            setUpPageControlView()
            // 刷新 collectionView
            collectionView.reloadData()
        }
    }
    
    /// 代理
    weak var delegate : ZJCarouselViewDelegate?
    
    /// Item总数量
    private var allItemsCount: NSInteger! = 1
    
    
    /// 自动滚动 默认开启
    var isAutoScroll: Bool = true {
        didSet {
            invalidateTimer()
            // 如果关闭无限循环，则不进行计时器的操作，否则每次滚动到最后一张就不在进行了。
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
    // 是否开启无限循环,默认 true 开启
    var isInfiniteLoop : Bool = true
    
    // 滚动方向,默认为水平方向
    var scrollDirection : UICollectionViewScrollDirection? = .horizontal {
        didSet{
            layout.scrollDirection = scrollDirection!
            if scrollDirection == .horizontal {
                position = .centeredHorizontally
            }else{
                position = .centeredVertically
            }
        }
    }
    
    /// Collection滚动方向
    var position : UICollectionViewScrollPosition = .centeredHorizontally
    /// 定时器
    private var timer : DispatchSourceTimer?
    
    /// UICollectionViewFlowLayout
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    // cell 的标识符 ID
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
    
    /// pageControl
    private var pageControl : UIPageControl?
    
    /// pageControl 样式, 默认为系统样式
    var pageStyle : ZJPageControlStyle = .image
    
    /// pageControlTintColor 默认的点颜色
    var pageControlTintColor: UIColor = UIColor.lightGray
    /// pageControlCurrentPageColor 滚动到的索引点颜色
    var pageControlCurrentPageColor: UIColor = UIColor.red
    // 图片
    var pageControlNormalImage: UIImage? = nil
    var pageControlCurrentImage: UIImage? = nil
    /// pageControlPosition
    var pageControlPosition: ZJPageControlPosition = .center
    // pageControl 图片的宽
    var pageControlImageVWidth : CGFloat? = 10
    // pageControl 图片的高
    var pageControlImageVHeight: CGFloat? = 0
    // pageControl 图片的高
    var pageControlImageVCornerRadius : CGFloat? = 0
    
    
    /// Bottom
    var pageControlBottom: CGFloat = 15 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var customPageControl: UIView?
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setUpAllView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .lightGray
        setUpAllView()
    }
    
}

// MARK: 配置 UI 视图
extension ZJCarouselView {
    
    private func setUpAllView() {
        // 添加 UICollectionView
        self.addSubview(self.collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = self.bounds
        
        // 计算最大扩展区大小
        if scrollDirection == .horizontal {
            maxSwipeSize = CGFloat(imageNamesOrURL.count) * collectionView.frame.width
        }else{
            maxSwipeSize = CGFloat(imageNamesOrURL.count) * collectionView.frame.height
        }
        
        // 设置 Cell Size
        layout.itemSize = self.frame.size
        
        // 设置 pageControl的 frame
        if pageStyle == .none || pageStyle == .system || pageStyle == .image{
            if pageControlPosition == .center{
                pageControl?.frame = CGRect.init(x: 0, y: self.frame.size.height-pageControlBottom, width: UIScreen.main.bounds.width, height: 10)
            }
        }
        
        if collectionView.contentOffset.x == 0 && allItemsCount > 0 {
            var targetIndex = 0
            if isInfiniteLoop {
                targetIndex = allItemsCount/2
            }
            collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: false)
        }
        
        
        // 开启自动滚动
        isAutoScroll = true
    }
}


// MARK: 配置 PageControl
extension ZJCarouselView {
    
    private func setUpPageControlView() {
        if pageControl != nil {
            pageControl?.removeFromSuperview()
        }
        guard imageNamesOrURL.count >= 1 else {return}
        
        switch pageStyle {
        // 默认样式
        case .none:
            pageControl = UIPageControl()
            pageControl?.numberOfPages = imageNamesOrURL.count
            // 系统样式
        case .system:
            pageControl = UIPageControl()
            pageControl?.numberOfPages = imageNamesOrURL.count
            pageControl?.pageIndicatorTintColor = pageControlTintColor
            pageControl?.currentPageIndicatorTintColor = pageControlCurrentPageColor
            self.addSubview(pageControl!)
        
            //图片
        case .image:
            pageControl = ZJImagePageControl()
            pageControl?.pageIndicatorTintColor = UIColor.clear
            pageControl?.currentPageIndicatorTintColor = UIColor.clear
            pageControl?.numberOfPages = imageNamesOrURL.count
            
            // 设置默认图片
            (pageControl as? ZJImagePageControl)?.kNormalImage = pageControlNormalImage != nil ? pageControlNormalImage : nil
            // 设置选中图片
            (pageControl as? ZJImagePageControl)?.kCurrentImage =  pageControlCurrentImage != nil ? pageControlCurrentImage : nil
            // 设置图片的宽度
            (pageControl as? ZJImagePageControl)?.kImageVW =  pageControlImageVWidth! > CGFloat(0) ? pageControlImageVWidth! : CGFloat(0)
            // 设置图片的高度
            (pageControl as? ZJImagePageControl)?.kImageVH =  pageControlImageVHeight! > CGFloat(0) ? pageControlImageVHeight! : CGFloat(0)
            // 设置图片的圆角大小
            (pageControl as? ZJImagePageControl)?.kImageVCornerRadius =  pageControlImageVCornerRadius! > CGFloat(0) ? pageControlImageVCornerRadius! : CGFloat(0)

            self.addSubview(pageControl!)
        }
    }
}

// MARK: 定时器
extension ZJCarouselView {
    
    // 开启定时器
    private func setUpTimer() {
        
        // 图片小于一张不启动定时器
        guard self.imageNamesOrURL.count > 1  else { return }
    
        let zj_timer = DispatchSource.makeTimerSource()
        zj_timer.schedule(deadline: .now()+autoScrollTimeInterval, repeating: autoScrollTimeInterval)
        zj_timer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.automaticScroll()
            }
        }
        // 继续
        zj_timer.resume()
        
        timer = zj_timer
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
        if allItemsCount == 0 {return}
        let targetIndex = getCurrentIndex() + 1
        scrollToIndex(targetIndex: targetIndex)
    }
    
    
    // 获取当前的索引 index
    private func getCurrentIndex() -> NSInteger {
        
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
            collectionView.scrollToItem(at: IndexPath(item: Int(allItemsCount / 2), section: 0), at: position, animated: false)
        }
        
        collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: position, animated: true)
    }
    
    
    /// PageControl当前下标对应的Cell位置
    func pageControlIndexWithCurrentCellIndex(index: NSInteger) -> (Int) {
        return imageNamesOrURL.count == 0 ? 0 : Int(index % imageNamesOrURL.count)
    }
    
}

// MARK: - 遵守UICollectionViewDelegate,UICollectionViewDataSource协议与数据源
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
        
        delegate?.zj_carouseView!(self, didSelectedItemIndex: pageControlIndexWithCurrentCellIndex(index: indexPath.item))
    
        
    }
}


// MARK: UIScrollViewDelegate 滚动代理事件
extension ZJCarouselView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 图片少于一张直接返回
        guard imageNamesOrURL.count > 0 else { return }
        
        // 当前滚动到第几个
        let indexOnPageControl = pageControlIndexWithCurrentCellIndex(index: getCurrentIndex())
        
        if pageStyle == .none || pageStyle == .system || pageStyle == .image{
            pageControl?.currentPage = indexOnPageControl
        }
        
        if scrollDirection == .horizontal {
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
                collectionView.scrollToItem(at: IndexPath.init(item: Int(allItemsCount/2), section: 0), at: position, animated: false)
            }
            
        }else{
            
            var currentOffsetY = scrollView.contentOffset.y - (CGFloat(allItemsCount) * scrollView.frame.size.height) / 2
            
            if currentOffsetY < 0 {
                if currentOffsetY >= -scrollView.frame.size.height{
                    currentOffsetY = CGFloat(indexOnPageControl) * scrollView.frame.size.height
                }else if currentOffsetY <= -maxSwipeSize{
                    collectionView.scrollToItem(at: IndexPath.init(item: Int(allItemsCount/2), section: 0), at: position, animated: false)
                }else{
                    currentOffsetY = maxSwipeSize + currentOffsetY
                }
            }
            if currentOffsetY >= CGFloat(self.imageNamesOrURL.count) * scrollView.frame.size.height && isInfiniteLoop{
                collectionView.scrollToItem(at: IndexPath.init(item: Int(allItemsCount/2), section: 0), at: position, animated: false)
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
        
        // 滚动后的回调协议
        delegate?.zj_carouseView!(self, scrollTo: pageControlIndexWithCurrentCellIndex(index: getCurrentIndex()))
        print("结束拖动时候的事件")
        // 开启定时器
        if isAutoScroll {
             setUpTimer()
        }
    }
    
    /// 自动滚动结束的时候调用的事件
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard imageNamesOrURL.count > 0 else { return }
        print("自动滚动结束的时候调用的事件")
        // 滚动后的回调协议
        delegate?.zj_carouseView!(self, scrollTo: pageControlIndexWithCurrentCellIndex(index: getCurrentIndex()))
        
        // 开启定时器
        if timer == nil && isAutoScroll {
            setUpTimer()
        }
    }
}
