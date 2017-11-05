//
//  DrinksCollectionViewLayout.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DrinksCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(width: CGFloat, height: CGFloat) {
        self.init()
        
        let edgeInset: CGFloat = 16.0
        let inset: CGFloat = 8.0
        
        self.sectionInset = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        self.itemSize = CGSize(width: width, height: height)
        self.minimumLineSpacing = inset
        self.minimumInteritemSpacing = inset
        
        self.scrollDirection = .vertical
    }
    
}
