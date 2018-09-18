//
//  ZJPageContentView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/31.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


protocol ZJPageContentViewDelegate : class {
    func zj_pageContentView(contentView : ZJPageContentView,progress : CGFloat, sourceIndex : Int,targetIndex : Int)
}


/// 自定义数据源协议 ,必须实现 zj_pageControlViewDataScoure 方法
@objc protocol ZJPageControlViewDataScoure : class {
    @objc func zj_pageControlViewDataScoure(contentView: ZJPageContentView, cellForItemAt indexPath: IndexPath) -> ZJBasePageControlCell
}
private let ContentCellID = "ContentCellID"

class ZJPageContentView: UIView {
    
    // 代理协议
    weak var delegate : ZJPageContentViewDelegate?
    // 自定义数据源协议
    weak var dataScoure : ZJPageControlViewDataScoure?
    // 禁止点击的时候走代理的方法
    private var isForbidScrollDelegate : Bool = false
    // 自控制器数组
    private var childVCs : [UIViewController]
    // 父控制器 weak 修饰,防止循环引用
    private weak var parentViewController : UIViewController?
    // 滑动偏移量
    private var startOffSetX : CGFloat = 0

    private lazy var layout : UICollectionViewFlowLayout = {
        // 创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self.bounds.size)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    // collectionView 容器
    private lazy var collectionView : UICollectionView = { [weak self] in
        
        // 创建 UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate =  self
        collectionView.backgroundColor = kWhite
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    init(frame : CGRect, childVCs : [UIViewController] ,parentViewController : UIViewController?) {
        
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        print(frame)
        super.init(frame:frame)
        
        setUpView()
        
    }
    func refreshColllectionView(height : CGFloat) {
        collectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
        layout.itemSize = collectionView.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - 对外暴露的方法
extension ZJPageContentView {
    
    // 切换控制器
    func setCurrentIndex(currentIndex: Int) {
        
        // 记录是否需要禁止执行的代理方法
        isForbidScrollDelegate = true
        
        // 滚到正确的位置
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false )
        
    }
}

// 设置 UI
extension ZJPageContentView{
    private func setUpView(){
        // 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            self.parentViewController?.addChildViewController(childVC)
        }
        
        // 添加 UIColletionView 存放子控制器的 View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK: - 遵守协议
extension ZJPageContentView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (dataScoure != nil) {
            // 自定义 cell 继承 ZJBasePageControlCell
            let item = dataScoure?.zj_pageControlViewDataScoure(contentView: self, cellForItemAt: indexPath)
            return item!
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds 
        cell.contentView.addSubview(childVC.view)
        cell.backgroundColor = kWhite
        return cell
        
    }
    
    // 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 记录是否需要禁止执行的代理方法
        isForbidScrollDelegate = false
        
        startOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 判断是点击事件还是滑动,点击事件不走下面的计算,滑动走下面的计算
        if isForbidScrollDelegate {
            return 
        }
        // 获取需要的数据资源
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 判断左滑还是右滑
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffSetX > startOffSetX {
             // 左滑
            // 1.计算 progress
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            // 2.计算 sourceIndex
            sourceIndex = Int(currentOffSetX / scrollViewW)
            // 3.计算 targetIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVCs.count  {
                targetIndex = childVCs.count - 1
            }
            
            // 4. 如果完全划过去了, progress = 1
            if currentOffSetX - startOffSetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            // 右滑
            // 计算 progress
            progress = 1  - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW))
            // 2.计算 targetIndex
            targetIndex = Int(currentOffSetX / scrollViewW)
            // 3.计算 sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVCs.count  {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.zj_pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
//        print("progress:\(progress)  targetIndex:\(targetIndex)  sourceIndex:\(sourceIndex)")
    }

}
