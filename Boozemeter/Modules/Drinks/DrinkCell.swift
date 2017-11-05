//
//  DrinkCell.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DrinkCell: UICollectionViewCell {
    
    // MARK: View lifecycle
    lazy var drinkView: DrinkView = {
        let view = DrinkView()
        
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return view
    }()
    
    // MARK: Setup
    func setup(with drink: Drink) {
        drinkView.imageView.image = UIImage(named: drink.imageName)
        drinkView.titleLabel.text = drink.title
    }
    
}
