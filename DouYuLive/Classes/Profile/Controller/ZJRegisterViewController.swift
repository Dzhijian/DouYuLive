//
//  ZJRegisterViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/13.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import RxSwift
class ZJRegisterViewController: ZJBaseViewController {

    private lazy var bag : DisposeBag = DisposeBag()
    
    private lazy var registerView : ZJLoginView = {
        let registerView = ZJLoginView(frame: CGRect.zero,viewType: ZJLoginType.ZJRegister)
        return registerView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(goBackAction))
        
        self.view.addSubview(registerView)
        registerView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        registerView.actionBtn.rx.tap
            .subscribe(onNext: {
                print("注册")
//                ZJAlertView.zj_showAlertView(currentController: self, title: "提示", message: "message", confirmTitle: "确定", cancelTitle: "取消", confirmHandler: { (action) in
//                    print("确定")
//                }, cancelHandel: { (action) in
//                    print("取消")
//                })
                
                ZJAlertView.zj_showSheetView(currentController: self, title: "haha", message: "hehe", actionArray: ["123","asd"], confirmTitle: "确定", cancelTitle: "取消", actionHandler: { (action) in
                    print(action.title ?? "000")
                }, cancelHandel: { (action) in
                    
                })
            })
            .disposed(by: bag)
            
    }
    
    @objc func goBackAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
