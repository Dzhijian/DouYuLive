//
//  ZJProgressHUD.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/26.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJProgressHUD: NSObject {
    static var timerTimes = 0
    static var timer: DispatchSource!
    static let rv = UIApplication.shared.keyWindow?.subviews.first as UIView?
    static var showViews = Array<UIView>()
    static var hudBackgroundColor: UIColor = UIColor.clear
    
    
    public class func showAnimationImages(supView : UIView, bgFrame: CGRect, imgArr : [UIImage] = [UIImage](),timeMilliseconds: Int = 0,bgColor : UIColor? = UIColor.white, scale : Double = 1.0) {
        
        self.showProgress(supView:supView,bgFrame:bgFrame,imgArr:imgArr,timeMilliseconds:timeMilliseconds,bgColor:bgColor,scale:scale)
        
    }
    
    static func showProgress(supView : UIView,bgFrame: CGRect? = nil,imgArr : [UIImage] = [UIImage](),timeMilliseconds: Int = 0,bgColor : UIColor? = UIColor.white, scale : Double = 1.0){
        
        var supFrame = supView.frame
        if bgFrame != nil {
            supFrame = bgFrame!
        }
        
        print(supFrame)
        let bgView = UIView()
        bgView.isHidden = false
        bgView.backgroundColor = bgColor
        
        let imgViewFrame = CGRect(x: Double(supFrame.size.width) * (1 - scale) * 0.5, y: Double(supFrame.size.height) * (1 - scale) * 0.5, width: Double(supFrame.size.width) * scale, height: Double(supFrame.size.height) * scale)
        
        if imgArr.count > 0 {
            if imgArr.count > timerTimes {
                let iv = UIImageView(frame: imgViewFrame)
                iv.image = imgArr.first!
                iv.contentMode = UIViewContentMode.scaleAspectFit
                bgView.addSubview(iv)
                timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: DispatchQueue.main) as! DispatchSource
                timer.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.milliseconds(timeMilliseconds))
                timer.setEventHandler(handler: { () -> Void in
                    let name = imgArr[timerTimes % imgArr.count]
                    iv.image = name
                    timerTimes += 1
                })
                timer.resume()
            }
        }
        
        bgView.frame = supFrame
//        bgView.center = rv!.center
        supView.addSubview(bgView)
        showViews.append(bgView)
        
        bgView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            bgView.alpha = 1
        })
    }
    
    static func clear() {
        self.cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        showViews.removeAll()
    }
    
    /// Clear all
    public class func hideAllHUD() {
        self.closePUB()
    }
    static func closePUB() {
        self.cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        for (_,view) in showViews.enumerated() {
            view.isHidden = true
//            view.removeFromSuperview()
        }
    }
}


extension UIViewController {
    class func zj_currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return zj_currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return zj_currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return zj_currentViewController(base: presented)
        }
        return base
    }
}
