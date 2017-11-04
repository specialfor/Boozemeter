//
//  DashboardInfoView.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DashboardInfoView: View {
    
    // MARK: Views
    lazy var titleLabel: UILabel = {
        let label = UILabel(textColor: theme.darkGreyTextColor, fontSize: 14.0)
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(8.0)
        })
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel(textColor: theme.textColor, fontSize: 16.0)
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8.0)
        })
        
        return label
    }()
    
    // MARK: Setup
    override func baseSetup() {
        valueLabel.isHidden = false
    }
    
}
