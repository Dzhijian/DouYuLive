//
//  ZJCateSectionHeaderView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCateSectionHeaderView: ZJBaseView {
    // 定义按钮点击的返回闭包
    var btnClickBlock:((_ index : Int)-> ())?
    
    private var kMargin : CGFloat = Adapt(30)
    
    private var btnArr : [UIButton] = {
        let btnArr = [UIButton]()
        return btnArr
    }()
    
    private var selectedIndex : Int = 0
    
    var titles : [String] = [String]()
    
    override func zj_initWithAllView() {

        setUpAllView()
        
        backgroundColor = kWhite
    }
    
    
    func setUpTitles(titles: [String] , margin : CGFloat? = nil , selectIndex : Int? = nil) {
        self.titles = titles
        
        if selectIndex != nil {
            self.selectedIndex = selectIndex!
        }
        
        if margin != nil {
            kMargin = margin!
        }
        guard self.btnArr.count == 0  else {
            // 如果存在则返回不再走下面的代码
            return
        }
        
        for (index,title) in titles.enumerated() {
            let btn : UIButton = UIButton()
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(kMainTextColor, for: .normal)
            btn.titleLabel?.font = BoldFontSize(18)
            btn.titleLabel?.backgroundColor = kWhite
            btn.tag = index + kBaseTarget
            
            btn.addTarget(self, action: #selector(self.btnClickAction(btn:)), for: UIControlEvents.touchUpInside)
            addSubview(btn)
            btnArr.append(btn)
        }
    
        if btnArr.count > 0 {
            btnClickAction(btn: btnArr[self.selectedIndex])
        }
    }

}

// MARK: - 点击事件
extension  ZJCateSectionHeaderView {
    
    @objc private func btnClickAction(btn: UIButton) {
     
        self.selectedIndex = btn.tag - kBaseTarget
        
        for (_,item) in btnArr.enumerated() {
            if ((item.tag - kBaseTarget) == self.selectedIndex) {
                item.setTitleColor(kMainOrangeColor, for: .normal)
            }else{
                item.setTitleColor(kMainTextColor, for: .normal)
            }
        }
        
        
        if btnClickBlock != nil {
            btnClickBlock!(self.selectedIndex)
        }
        
    }
}



// 配置 UI 视图
extension ZJCateSectionHeaderView {
    
    private func setUpAllView() {
        _ = UIView.zj_createView(bgClor: klineColor, supView: self, closure: { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.8)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnH = frame.size.height
        let btnY: CGFloat = 0
        var btnW: CGFloat = 0
        var btnX: CGFloat = 0
        
        for (index,btn) in self.btnArr.enumerated() {
            
            btnW = (titles[index] as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : btn.titleLabel?.font ?? UIFont.systemFont(ofSize: 14)], context: nil).width
            btnX = index == 0 ? kMargin * 0.5 : (btnArr[index-1].frame.maxX + kMargin)
            
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        }
        
    }
}
