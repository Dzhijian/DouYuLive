//
//  ZJLoginViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/13.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import RxSwift

class ZJLoginViewController: ZJBaseViewController {

    private lazy var bag : DisposeBag = DisposeBag()
    private lazy var loginView : ZJLoginView = {
        let loginView = ZJLoginView(frame: CGRect.zero,viewType: ZJLoginType.ZJLogin)
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "手机登录", style: .done, target: self, action: #selector(goBackAction))
        
        // 添加登录视图
        self.view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        loginView.actionBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showAlert()
            })
            .disposed(by: bag)
    }

    @objc func goBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func showAlert() {
        SwiftProgressHUD.showWait()
        /// 模拟 1s后 加载完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SwiftProgressHUD.hideAllHUD()
            self.dismiss(animated: true, completion: nil)
//             UIApplication.shared.keyWindow?.rootViewController = ZJTabBarController()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
