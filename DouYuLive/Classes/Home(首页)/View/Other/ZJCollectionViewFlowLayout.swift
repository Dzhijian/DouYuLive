//
//  ZJCollectionViewFlowLayout.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: -
extension ZJCollectionViewFlowLayout {
    //边界发生变化时是否重新布局（视图滚动的时候也会调用）
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //从父类得到默认的所有元素属性
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect)
            else { return nil }
        
        //用于存储元素新的布局属性,最后会返回这个
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
        //存储每个layout attributes对应的是哪个section
        let sectionsToAdd = NSMutableIndexSet()
        
        //循环老的元素布局属性
        for layoutAttributesSet in layoutAttributes {
            //如果元素师cell
            if layoutAttributesSet.representedElementCategory == .cell {
                //将布局添加到newLayoutAttributes中
                newLayoutAttributes.append(layoutAttributesSet)
            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
                //将对应的section储存到sectionsToAdd中
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }
        
        //遍历sectionsToAdd，补充视图使用正确的布局属性
        for section in sectionsToAdd {
            let indexPath = IndexPath(item: 0, section: section)
            
            //添加头部布局属性
            if let headerAttributes = self.layoutAttributesForSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, at: indexPath) {
                newLayoutAttributes.append(headerAttributes)
            }
            
            //添加尾部布局属性
            if let footerAttributes = self.layoutAttributesForSupplementaryView(ofKind:
                UICollectionElementKindSectionFooter, at: indexPath) {
                newLayoutAttributes.append(footerAttributes)
            }
        }
        
        return newLayoutAttributes
    }
    
    //补充视图的布局属性(这里处理实现粘性分组头,让分组头始终处于分组可视区域的顶部)
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                       at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //先从父类获取补充视图的布局属性
        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind:
            elementKind, at: indexPath) else { return nil }
        
        //如果不是头部视图则直接返回
        if elementKind != UICollectionElementKindSectionHeader {
            return layoutAttributes
        }
        
        //根据section索引，获取对应的边界范围
        guard let boundaries = boundaries(forSection: indexPath.section)
            else { return layoutAttributes }
        guard let collectionView = collectionView else { return layoutAttributes }
        
        //保存视图内入垂直方向的偏移量
        let contentOffsetY = collectionView.contentOffset.y
        //补充视图的frame
        var frameForSupplementaryView = layoutAttributes.frame
        
        //计算分组头垂直方向的最大最小值
        let minimum = boundaries.minimum - frameForSupplementaryView.height
        let maximum = boundaries.maximum - frameForSupplementaryView.height
        
        //如果内容区域的垂直偏移量小于分组头最小的位置，则将分组头置于其最小位置
        if contentOffsetY < minimum {
            frameForSupplementaryView.origin.y = minimum
        }
            //如果内容区域的垂直偏移量大于分组头最小的位置，则将分组头置于其最大位置
        else if contentOffsetY > maximum {
            frameForSupplementaryView.origin.y = maximum
        }
            //如果都不满足，则说明内容区域的垂直便宜量落在分组头的边界范围内。
            //将分组头设置为内容偏移量，从而让分组头固定在集合视图的顶部
        else {
            frameForSupplementaryView.origin.y = contentOffsetY
        }
        
        //更新布局属性并返回
        layoutAttributes.frame = frameForSupplementaryView
        return layoutAttributes
    }
    
    //根据section索引，获取对应的边界范围（返回一个元组）
    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
        //保存返回结果
        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
        
        //如果collectionView属性为nil，则直接fanhui
        guard let collectionView = collectionView else { return result }
        
        //获取该分区中的项目数
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        
        //如果项目数位0，则直接返回
        guard numberOfItems > 0 else { return result }
        
        //从流布局属性中获取第一个、以及最后一个项的布局属性
        let first = IndexPath(item: 0, section: section)
        let last = IndexPath(item: (numberOfItems - 1), section: section)
        if let firstItem = layoutAttributesForItem(at: first),
            let lastItem = layoutAttributesForItem(at: last) {
            //分别获区边界的最小值和最大值
            result.minimum = firstItem.frame.minY
            result.maximum = lastItem.frame.maxY
            
            //将分区都的高度考虑进去，并调整
            result.minimum -= headerReferenceSize.height
            result.maximum -= headerReferenceSize.height
            
            //将分区的内边距考虑进去，并调整
            result.minimum -= sectionInset.top
            result.maximum += (sectionInset.top + sectionInset.bottom)
        }
        
        //返回最终的边界值
        return result
    }
}
