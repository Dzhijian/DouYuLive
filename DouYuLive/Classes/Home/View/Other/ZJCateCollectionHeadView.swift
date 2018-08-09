//
//  ZJCateCollectionHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
// ColletionView 一行的高度
private let  kColH : CGFloat = AdaptW(40)

protocol ZJCateItemSelectedDelegate : class {
    
    func cateItemSelected(cateId: String, index : Int)
    
}
class ZJCateCollectionHeadView: UICollectionReusableView {
    
    weak var delegate : ZJCateItemSelectedDelegate?
    private var selectIndex : Int = 0
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = kWhite
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.register(ZJSelectCateItem.self, forCellWithReuseIdentifier: ZJSelectCateItem.identifier())
        return collectionView
    }()
    
    private lazy var line = UIView()
    private lazy var moreBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn_video_arrow_down"), for: .normal)
        btn.backgroundColor = kWhite
        btn.addTarget(self, action: #selector(self.moreBtnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var dataList : [ZJChildCateList] = [ZJChildCateList]()
    
    var cateList : [ZJChildCateList]? {
        didSet{
            self.dataList.removeAll()
            var cateItem = ZJChildCateList()
            cateItem.id = "1"
            cateItem.name = "全部"
            self.dataList.append(cateItem)
            guard ((cateList?.count) != nil) else {
                return
            }
            for (_,item) in (cateList?.enumerated())! {
                self.dataList.append(item)
            }
            self.collectionView.reloadData()
            if self.moreBtn.isSelected {
                hiddenChildCateView()
            }
        }
    }
    
    
    private var showNum : Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
        
    }
    
    
    // 更多列表展开事件
    @objc func moreBtnClick(sender: UIButton) {
        
        if sender.isSelected {
            
            
            // 隐藏
            hiddenChildCateView()
            
        }else{
            // 显示
            showChildCateView()
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 显示隐藏子类分类
extension ZJCateCollectionHeadView {
    // 显示子类视图
    private func showChildCateView (){
        self.moreBtn.isSelected = true
        let frame : CGRect = self.frame
        let colframe : CGRect = self.collectionView.frame
        self.moreBtn.isHidden = true
        self.showNum = 4
        
        let column : Int?
        let quotient = self.dataList.count / self.showNum
        let remainder  = self.dataList.count % self.showNum
        
        if remainder == 0 {
            column = quotient-1
        }else if remainder != 0 && quotient > 0{
            column = quotient
        }else{
            column = 0
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.size.height  = frame.size.height + kColH * CGFloat(column!) + Adapt(30)
            self.collectionView.frame.size.height = colframe.size.height + kColH * CGFloat(column!)
        }) { (isSuccess) in
            if isSuccess {
                self.moreBtn.isHidden = false
                self.moreBtn.setImage(UIImage(named: "btn_video_arrow_up"), for: .normal)
                self.line.isHidden = false
                self.collectionView.reloadData()
            }
        }
       
    }
    
    // 隐藏子类视图
    private func hiddenChildCateView (){
        self.moreBtn.isSelected = false
        self.line.isHidden = true
        self.showNum = 5
        UIView.animate(withDuration: 0.25, animations: {
            self.frame  = CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(40))
            self.collectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kColH)
            self.moreBtn.isHidden = true
        }) { (isSuccess) in
            if isSuccess {
                self.moreBtn.setImage(UIImage(named: "btn_video_arrow_down"), for: .normal)
                self.moreBtn.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
}

extension ZJCateCollectionHeadView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJSelectCateItem.identifier(), for: indexPath) as! ZJSelectCateItem
        let model = self.dataList[indexPath.item]
        item.titleLab.text = model.name
        if selectIndex == indexPath.item {
            item.titleLab.textColor = kMainOrangeColor
        }else{
            item.titleLab.textColor = kGrayTextColor
        }
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW / CGFloat(showNum) , height: kColH)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex = indexPath.item
        let model = self.dataList[indexPath.item]
        delegate?.cateItemSelected(cateId: model.id!,index: indexPath.item)
        self.collectionView.reloadData()
    }
}

// MARK: - 配置 UI
extension ZJCateCollectionHeadView {
    
    private func setUpAllView() {
        backgroundColor = kWhite
        self.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kColH)
        
        self.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.height.equalTo(kColH)
        }
        
        self.line = UIView.zj_createView(bgClor: klineColor, supView: self, closure: { (make) in
            make.bottom.equalTo(-35)
            make.left.right.equalTo(0)
            make.height.equalTo(0.8)
        })
        self.line.isHidden = true
    }
    
    
}
