//
//  AccessDeclinedViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/6/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class AccessDeclinedViewController: ViewController {
    
    // MARK:
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        let inset = 16.0
        
        label.textAlignment = .center
        
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
            make.center.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var tryButton: Button = {
        let button = Button()
        
        let inset = 16.0
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.height.equalTo(44)
            make.right.bottom.equalTo(-inset)
        })
        
        return button
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.isHidden = false
        
        tryButton.setTitle("Разблокировать", for: .normal)
        tryButton.addTarget(self, action: #selector(tryTapped), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc private func tryTapped() {
        LocalAuthService.tryAuth()
    }
    
    // MARK: Show
    func show() {
        toggle(shoulHide: false)
    }
    
    func hide() {
        toggle(shoulHide: true)
    }
    
    private func toggle(shoulHide: Bool) {
        titleLabel.isHidden = shoulHide
        tryButton.isHidden = shoulHide
    }
    
}
