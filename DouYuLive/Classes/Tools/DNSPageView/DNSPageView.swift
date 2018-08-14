//
//  DNSPageView.swift
//  DNSPageView
//
//  Created by Daniels on 2018/2/24.
//  Copyright © 2018年 Daniels. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

/*
 通过这个类创建的pageView，默认titleView和contentView连在一起，效果类似于网易新闻
 只能用代码创建，不能在xib或者storyboard里面使用
 */
open class DNSPageView: UIView {
    
    private (set) public var style: DNSPageStyle
    private (set) public var titles: [String]
    private (set) public var childViewControllers: [UIViewController]

    private (set) public lazy var titleView = DNSPageTitleView(frame: .zero, style: style, titles: titles)
    private (set) public lazy var contentView = DNSPageContentView(frame: .zero, style: style, childViewControllers: childViewControllers)


    public init(frame: CGRect, style: DNSPageStyle, titles: [String], childViewControllers: [UIViewController]) {
        self.style = style
        self.titles = titles
        self.childViewControllers = childViewControllers
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension DNSPageView {
    private func setupUI() {
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewHeight)
        titleView.frame = titleFrame
        addSubview(titleView)
        
        // 设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = frame
        titleView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        let contentFrame = CGRect(x: 0, y: style.titleViewHeight, width: bounds.width, height: bounds.height - style.titleViewHeight)
        contentView.frame = contentFrame
        contentView.backgroundColor = UIColor.white
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
