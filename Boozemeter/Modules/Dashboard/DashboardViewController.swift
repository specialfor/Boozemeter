//
//  DashboardViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DashboardViewController: ViewController {
    
    var alcoholService: AlcoholStateService!
    
    // MARK: Views
    lazy var headerView: DashboardHeaderView = {
        let view = DashboardHeaderView()
        
        view.backgroundColor = theme.mainColor
        view.addShadow()
        
        self.view.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview()
        })
        
        return view
    }()
    
    lazy var resorptionTimeView: DashboardInfoView = {
        let view = DashboardInfoView()
        
        let inset = 16.0
        
        self.view.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.top.equalTo(headerView.snp.bottom).offset(inset)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
            
            make.height.equalTo(60.0)
        })
        
        return view
    }()
    
    
    lazy var resorptionDateView: DashboardInfoView = {
        let view = DashboardInfoView()
        
        self.view.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.top.equalTo(resorptionTimeView.snp.bottom).offset(16.0)
            make.left.right.equalTo(resorptionTimeView)
            
            make.height.equalTo(60.0)
        })
        
        return view
    }()
    
    lazy var addButton: Button = {
        let button = Button()
        
        button.backgroundColor = theme.accentColor
        
        let width: CGFloat = 52.0
        button.layer.cornerRadius = width / 2
        
        let inset = 16.0
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.right.bottom.equalTo(-inset)
            make.width.height.equalTo(width)
        })
        
        return button
    }()
    
    // MARK: View lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alcoholService = AlcoholStateService.shared
        alcoholService.delegate = self
        setupAlcoholState(alcoholService.alcoholState)
        
        configureNavBar()

        resorptionTimeView.titleLabel.text = "Время вывода алкоголя:"
        resorptionDateView.titleLabel.text = "Дата отрезвления:"
        
        addButton.setTitle("+", for: .normal)
        addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: Configuration
    private func configureNavBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Состояние"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(settingsTapped(_:)))
    }
    
    // MARK: Actions
    @objc private func settingsTapped(_ button: UIBarButtonItem) {
        // TODO: need to implement
    }
    
    @objc private func addTapped(_ button: UIButton) {
        SplashRouter.shared.showDrinks()
    }
    
    // MARK: Private Methods
    private func setupAlcoholState(_ state: AlcoholState) {
        headerView.concentrationValue = state.concentration
        
        let date = Date(timeIntervalSince1970: state.timestamp)
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.minute], from: date)
        
        resorptionTimeView.valueLabel.text = "через \(components.minute ?? 0) минут"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, h:mm a"
    
        resorptionDateView.valueLabel.text = dateFormatter.string(from: date)
    }
}

extension DashboardViewController: AlcoholStateServiceDelegate {
    
    func didAlcoholStateUpdated(_ service: AlcoholStateService, state: AlcoholState) {
        setupAlcoholState(state)
    }
    
}
