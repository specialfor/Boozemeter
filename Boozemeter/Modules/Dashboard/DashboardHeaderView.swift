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
    lazy var titleLabel: UILabel = {
        let label = UILabel(textColor: theme.selectedTextColor, fontSize: 16.0)
        
        label.textAlignment = .center
        
        label.text = "Boozemeter"
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(32)
            make.centerX.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(theme.selectedTextColor, for: .normal)
        
        self.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(titleLabel)
        })
        
        return button
    }()
    
    lazy var concTitleLabel: UILabel = {
        let label = UILabel(textColor: theme.selectedTextColor, fontSize: 14.0, weight: .light)
        
        label.text = "Концентрация:"
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.equalTo(16.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(32.0)
        })
        
        return label
    }()
    
    lazy var concValueLabel: UILabel = {
        let label = UILabel(textColor: theme.selectedTextColor, fontSize: 32.0)
        
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
        settingsButton.setTitle("Настройки", for: .normal)
        
        stateView.backgroundColor = .clear
    }
    
}
