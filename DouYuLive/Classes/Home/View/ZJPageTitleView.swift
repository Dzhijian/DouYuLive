//
//  ZJPageTitleView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/27.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

// 代理
protocol  PageTitleViewDelegate : class {
    
    func pageTitleView(titleView : ZJPageTitleView, selectedIndex index: Int)
}

// 滚动线的高度
private let scrollLineH : CGFloat = 2
private let klabelWidth : CGFloat = 80
// 定义颜色
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (220,220,220)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,255,255)
class ZJPageTitleView: UIView {
    // 代理协议
    weak var delegate : PageTitleViewDelegate?
    
    // 滚动 View
    private lazy var scrollerView : UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.scrollsToTop = false
        scrollerView.bounces = false
        return scrollerView
    }()
    
    // 底部滚动条
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = kWhite
        return scrollLine
    }()
    
    // 创建一个 label 数组
    private lazy var titleLabs : [UILabel] = [UILabel]()
    // 标题
    private var titles : [String]
    // 索引
    private var currentIndex : Int = 0
    
    init(frame : CGRect , titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ZJPageTitleView {
    
    private func setUpAllView() {
        // 添加 scrollerView
        addSubview(scrollerView)
        scrollerView.frame = bounds
        
        // 添加对应的 title
        setUpTitleLabel()
        
        // 设置底线滚动的滑块
        setBottomMenuAndScrollLine()
        
        // 设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setUpTitleLabel(){
        
        // 确定 lab的一些确定的值
//        let labW : CGFloat = frame.width / CGFloat(titles.count)
        let labH : CGFloat = frame.height  - scrollLineH
        let labY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            // 创建 label
            let lab = UILabel()
            lab.text = title
            lab.tag = index
            lab.font = FontSize(14)
            lab.textColor = colorWithRGBA(kNormalColor.0, kNormalColor.1, kNormalColor.2, 1.0)
            lab.textAlignment = .center
            let labX : CGFloat = klabelWidth * CGFloat(index)
            lab.frame = CGRect(x: labX, y: labY, width: klabelWidth, height: labH)
            // 添加 lab
            scrollerView.addSubview(lab)
            titleLabs.append(lab)
            
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGesture:)))
            lab.addGestureRecognizer(tap)
        }
        scrollerView.contentSize = CGSize(width: klabelWidth * CGFloat(titles.count), height: 40)
    }
    
    private func setBottomMenuAndScrollLine(){
        
        // 添加底部分割线 和 滚动线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let botH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-botH, width: frame.width, height: botH)
        addSubview(bottomLine)
        
        // 如果没有就返回
        guard let firstLab = titleLabs.first else { return }
        firstLab.textColor = colorWithRGBA(kSelectColor.0, kSelectColor.1, kSelectColor.2, 1.0)

        firstLab.font = BoldFontSize(15)
        // 添加 scrollLine
        scrollLine.frame = CGRect(x: firstLab.frame.origin.x, y: frame.height-scrollLineH, width: firstLab.frame.width, height: scrollLineH)
        scrollerView.addSubview(scrollLine)
        
    }
    

}


// MARK: - 对外暴露的方法
extension ZJPageTitleView {
    func setPageTitleWithProgress(progress: CGFloat,  sourceIndex: Int, targetIndex:Int) {
        // 取得 lab
        let sourceLab = titleLabs[sourceIndex]
        let targetLab = titleLabs[targetIndex]
        
        // 处理滑块
        let movtotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let movX = movtotalX * progress
        scrollLine.frame.origin.x = sourceLab.frame.origin.x + movX
        
        // 颜色的渐变
        // 取出颜色变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 变化 sourceLab 的文字颜色
        sourceLab.textColor = colorWithRGBA(kSelectColor.0 - colorDelta.0 * progress, kSelectColor.1 - colorDelta.1 * progress, kSelectColor.2 - colorDelta.2 * progress, 1.0)
        sourceLab.font = FontSize(16 - 2 * progress)
        
        // 变化 targetLab 的文字颜色
        targetLab.textColor = colorWithRGBA(kNormalColor.0 + colorDelta.0 * progress, kNormalColor.1 + colorDelta.1 * progress, kNormalColor.2 + colorDelta.2 * progress, 1.0)
        targetLab.font = BoldFontSize (14 + 2  * progress)
        
        // 记录最新的 index
        currentIndex = targetIndex
     }
}

// MARK: - 监听Label 的点击
extension ZJPageTitleView {
    
    @objc fileprivate func titleLabelClick(tapGesture : UITapGestureRecognizer) {
        
        // 如果下标相同,不做处理
        if tapGesture.view?.tag == currentIndex {
            return
        }
        // 获取当前 lab 的下标值
        let currentLab = tapGesture.view as? UILabel //else { return }
        
        // 获取之前的label
        let oldLab = titleLabs[currentIndex]
        
        // 切换文字颜色和字体大小
        currentLab?.textColor = colorWithRGBA(kSelectColor.0, kSelectColor.1, kSelectColor.2,  1.0)
        currentLab?.font = BoldFontSize (15)
        
        oldLab.textColor = colorWithRGBA(kNormalColor.0, kNormalColor.1, kNormalColor.2, 1.0)
        oldLab.font = FontSize(14)
        
        // 保存最新 lab 的下标值
        currentIndex = (currentLab?.tag)!
        
        // 滚动条位置发生改变
        let scrollLineX = CGFloat((currentLab?.tag)!) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 自动滚动到中间
        if scrollLine.frame.origin.x > kScreenW / 2 {
            scrollerView.setContentOffset(CGPoint(x: kScreenW / 2 - klabelWidth/2, y: 0), animated: true)
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
