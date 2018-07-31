//
//  ZJPageTitleView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/27.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

// 滚动线的高度
private let scrollLineH : CGFloat = 2

 class ZJPageTitleView: UIView {
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
        scrollLine.backgroundColor = MainOrangeColor
        
        return scrollLine
    }()
    
    // 创建一个 label 数组
    private lazy var titleLabs : [UILabel] = [UILabel]()
    
    private var titles : [String]
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
    }
    
    private func setUpTitleLabel(){
        
        // 确定 lab的一些确定的值
        let labW : CGFloat = frame.width / CGFloat(titles.count)
        let labH : CGFloat = frame.height  - scrollLineH
        let labY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            // 创建 label
            let lab = UILabel()
            lab.text = title
            lab.tag = index
            lab.font = FontSize(14 )
            lab.textColor = UIColor.darkGray
            lab.textAlignment = .center
            let labX : CGFloat = labW * CGFloat(index)
            lab.frame = CGRect(x: labX, y: labY, width: labW, height: labH)
            // 添加 lab
            scrollerView.addSubview(lab)
            titleLabs .append(lab)
        }
    }
    
    private func setBottomMenuAndScrollLine (){
        
        // 添加底部分割线 和 滚动线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let botH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-botH, width: frame.width, height: botH)
        addSubview(bottomLine)
        
        // 如果没有就返回
        guard let firstLab = titleLabs.first else { return }
        firstLab.textColor = MainOrangeColor
        // 添加 scrollLine
        scrollLine.frame = CGRect(x: firstLab.frame.origin.x, y: frame.height-scrollLineH, width: firstLab.frame.width, height: scrollLineH)
        scrollerView.addSubview(scrollLine)
        
    }
}
