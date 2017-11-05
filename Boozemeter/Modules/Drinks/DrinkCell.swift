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
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFit
        
        let side = 80
        
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(side)
        })
        
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(textColor: theme.textColor, fontSize: 14.0)
        
        label.textAlignment = .center
        
        let inset = 8.0
        
        self.contentView.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(imageView.snp.bottom).offset(inset)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return label
    }()
    
    // MARK: Setup
    func setup(with drink: Drink) {
        imageView.image = UIImage(named: drink.imageName)
        titleLabel.text = drink.title
    }
    
}
