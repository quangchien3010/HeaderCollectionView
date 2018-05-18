//
//  Extesion Collections.swift
//  headerCollectionView
//
//  Created by Admin on 5/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func layoutCollection(numberOfItem : CGFloat, padding : CGFloat) {
        let witdhScreen = UIScreen.main.bounds.width
        let witdhItem = (witdhScreen - padding * (numberOfItem + 1 ))/numberOfItem
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: witdhItem, height: 80)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .horizontal
        self.collectionViewLayout = layout
    }
}
