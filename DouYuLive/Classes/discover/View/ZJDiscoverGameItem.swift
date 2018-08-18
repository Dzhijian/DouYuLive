//
//  ZJDiscoverGameItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kCellHeight : CGFloat = Adapt(210)
class ZJDiscoverGameItem: ZJBaseCollectionCell {
    
    
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: frame, style: .plain)
        mainTable.backgroundColor = kWhite
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.separatorStyle = .none
        mainTable.register(ZJGameItemCell.self, forCellReuseIdentifier: ZJGameItemCell.identifier())
        mainTable.rowHeight = kCellHeight
        mainTable.layer.cornerRadius = 3
        mainTable.layer.masksToBounds = true
        return mainTable
    }()
    
    
    override func zj_setUpAllView() {
        backgroundColor = kPurple
        addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.left.equalTo(Adapt(5))
            make.right.equalTo(Adapt(-5))
            make.top.equalTo(Adapt(80))
            make.bottom.equalTo(Adapt(-80))
        }
    }
    
    var gameList : [ZJDiscoverGameList]?{
        didSet{
            self.mainTable.reloadData()
        }
    }
    
    
    override class func itemHeightWithModel(model : Any) -> CGSize {
        return CGSize(width: kScreenW, height: 2 * kCellHeight + Adapt(160)) 
    }
    
}

// MARK: - 遵守协议
extension ZJDiscoverGameItem : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZJGameItemCell.identifier(), for: indexPath) as! ZJGameItemCell
        cell.botLine.isHidden = indexPath.row == (self.gameList?.count)! - 1 ? true : false
        cell.model = self.gameList?[indexPath.row]
        return cell
    }
    
    
}
