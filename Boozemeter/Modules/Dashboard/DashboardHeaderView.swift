//
//  DashboardHeaderView.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DashboardHeaderView: View {
    
    // MARK: Views
    lazy var concTitleLabel: UILabel = {
        let label = UILabel(textColor: theme.selectedTextColor, fontSize: 18.0, weight: .light)
        
        label.text = "Концентрация:"
        
        let inset = 16.0
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.equalTo(inset)
            make.top.equalTo(inset)
        })
        
        return label
    }()
    
    lazy var concValueLabel: UILabel = {
        let label = UILabel(textColor: theme.selectedTextColor, fontSize: 52.0)
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(concTitleLabel.snp.bottom).offset(32.0)
            make.left.equalTo(concTitleLabel)
        })
        
        return label
    }()
    
    lazy var stateView: UIView = {
        let view = UIView()
        
        self.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.height.equalTo(4.0)
            
            make.top.equalTo(concValueLabel.snp.bottom).offset(16.0)
            make.left.right.bottom.equalToSuperview()
        })
        
        return view
    }()
    
    // MARK: Setup
    override func baseSetup() {
        concValueLabel.text = "0.00‰"
        
        stateView.backgroundColor = .green
    }
    
}
