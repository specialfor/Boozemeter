//
//  DrinkView.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DrinkView: View {
    
    var fontSize: CGFloat = 11.0 {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    // MARK: Views
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFit
        
        let side = 80
        
        self.addSubview(imgView)
        imgView.snp.makeConstraints({ (make) in
            make.width.height.equalTo(side)
            make.centerX.equalToSuperview()
            
            make.top.equalTo(8.0)
        })
        
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(textColor: theme.textColor, fontSize: fontSize)
        
        label.textAlignment = .center
        
        let inset = 8.0
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(imageView.snp.bottom).offset(inset)
            make.left.equalTo(inset)
            make.right.bottom.equalTo(-inset)
        })
        
        return label
    }()
    
}
