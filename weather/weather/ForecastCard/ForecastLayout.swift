//
//  CardLayout.swift
//  weather
//
//  Created by Петр Ларочкин on 25.08.2022.
//

import Foundation
import UIKit

class CardLayout: UICollectionViewLayout {
    //    https://manikarthi-vaiha.medium.com/apple-wallet-app-design-in-ios-c292304fcc13
    var bottomOffsetOfExpandedCard: CGFloat = 10
    var contentHeight: CGFloat = 0.0
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    var nextIndexPath: Int?
    var delegateIndexOfSelectedRow: HasIndexOfSelectedRow?
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     This method returns the width and height of the collection view’s contents. You must implement it to return the height and width of the entire collection view’s content, not just the visible content. The collection view uses this information internally to configure its scroll view’s content size.
     */
    override var collectionViewContentSize: CGSize {
        var size = super.collectionViewContentSize
        let collection = collectionView!
        size.width = collection.bounds.size.width
        if let _ = delegateIndexOfSelectedRow?.indexOfSelectedRow() {
            size.height = contentHeight + Settings.shared.longHeightOfCard
        } else {
            size.height = contentHeight
        }
        //        print("Contend", contentHeight)
        return size
    }
    
    
    func reloadData(){
        self.cachedAttributes = [UICollectionViewLayoutAttributes]()
    }
    
    /*
     Whenever a layout operation is about to take place, UIKit calls this method. It’s your opportunity to prepare and perform any calculations required to determine the collection view’s size and the positions of the items.
     */
    override func prepare() {
        cachedAttributes.removeAll()
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0) else {
            return
        }
        for index in 0..<numberOfItems {
            let layout = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: index, section: 0))
            layout.frame = frameFor(index: index)
            
            if let indexExpand = delegateIndexOfSelectedRow?.indexOfSelectedRow(), indexExpand == index {
                self.nextIndexPath = index+1
                contentHeight =
                CGFloat(numberOfItems) * Settings.shared.shortHeightOfCard + 2 * (Settings.shared.longHeightOfCard - Settings.shared.shortHeightOfCard)
            } else {
                contentHeight =
                CGFloat(numberOfItems) * Settings.shared.shortHeightOfCard + (Settings.shared.longHeightOfCard - Settings.shared.shortHeightOfCard)
            }
            layout.zIndex = index
            layout.isHidden = false
            
            cachedAttributes.append(layout)
        }
    }
    
    /*
     In this method, you return the layout attributes for all items inside the given rectangle. You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cachedAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(cachedAttributes[attributes.indexPath.item])
            }
            
        }
        return layoutAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    /*
     This method provides on demand layout information to the collection view. You need to override it and return the layout attributes for the item at the requested indexPath.
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    func frameFor(index: Int) -> CGRect {
        var frame = CGRect(
            origin: CGPoint(x: CGFloat(0), y:0),
            size: CGSize(
                width: (collectionView?.bounds.size.width ?? UIScreen.main.bounds.width),
                height: Settings.shared.longHeightOfCard))
        var frameOrigin = frame.origin
        if let indexExpand = delegateIndexOfSelectedRow?.indexOfSelectedRow() {
            if index > 0 {
                if indexExpand < index {
                    let spacesHeight =
                    Settings.shared.shortHeightOfCard * CGFloat(index) + (Settings.shared.longHeightOfCard - Settings.shared.shortHeightOfCard) + bottomOffsetOfExpandedCard
                    frameOrigin.y = spacesHeight
                } else {
                    frameOrigin.y = CGFloat((Settings.shared.shortHeightOfCard * CGFloat(index)))
                }
            }
        } else {
            if index > 0 {
                frameOrigin.y = CGFloat((Settings.shared.shortHeightOfCard * CGFloat(index)))
            }
        }
        frame.origin = frameOrigin
        return frame
    }
}

