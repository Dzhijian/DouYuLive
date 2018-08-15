//
//  ZJCateSectionHeaderView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCateSectionHeaderView: ZJBaseView {
    
    var titles : [String] = [String]()
    var btnArr : [UIButton] = [UIButton]()
    
    
    override func zj_initWithAllView() {

        setUpAllView()
        
        backgroundColor = kWhite
    }
    
    
    func setUpTitles(titles: [String]) {
        
        guard btnArr.count == 0  else {
            // 如果存在则返回不再走下面的代码
            return
        }
        
        let btnW : CGFloat = Adapt(60)
        let btnH : CGFloat = 50
        let btnY : CGFloat = (self.frame.size.height - btnH) / 2
        let margin : CGFloat = Adapt(15)
        
        for (index,title) in titles.enumerated() {
            let btn : UIButton = UIButton()
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(kMainTextColor, for: .normal)
            btn.titleLabel?.font = BoldFontSize(18)
            btn.titleLabel?.backgroundColor = kWhite
            let btnX = margin + CGFloat(index) * btnW + margin * CGFloat(index)
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.tag = index + kBaseTarget
            btn.addTarget(self, action: #selector(self.btnClickAction(btn:)), for: UIControlEvents.touchUpInside)
            addSubview(btn)
            btnArr.append(btn)
        }
        
        if btnArr.count > 0 {
            
            btnClickAction(btn: btnArr.first!)
        }
    }

}

// MARK: - 点击事件
extension  ZJCateSectionHeaderView {
    
    @objc private func btnClickAction(btn: UIButton) {
        
        let index = btn.tag
        for btn in btnArr {
            
            if btn.tag == index {
                btn.setTitleColor(kMainOrangeColor, for: .normal)
            }else{
                btn.setTitleColor(kMainTextColor, for: .normal)
            }
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
        
    }
}
