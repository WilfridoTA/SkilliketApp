//
//  FormCompositionalLayout.swift
//  Skilliket
//
//  Created by Nicole  on 06/10/24.
//

import Foundation
import UIKit

//item
final class FormCompositionalLayout{
    var layout: UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(18), trailing: nil, bottom: .fixed(18))
        
        //group
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitem: layoutItem, count: 1)
        layoutGroup.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        //section
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(top: 40, leading: 0, bottom: 0, trailing: 0)
        layoutSection.interGroupSpacing = 2
        
        let compLayout = UICollectionViewCompositionalLayout(section: layoutSection)
        return compLayout
        
    }
    
}
