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
    var alcoholLevel: AlcoholLevel? {
        didSet {
            setupLevel()
        }
    }
    
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
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(Constants.LocalizableKeys.reset.localized, for: .normal)
        button.setTitleColor(theme.accentColor, for: .normal)
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.top.equalTo(resorptionDateView.snp.bottom).offset(16.0)
            make.left.right.equalTo(resorptionDateView)
            make.height.equalTo(44.0)
        })
        
        return button
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
        
        configureNavBar()

        resorptionTimeView.titleLabel.text = Constants.LocalizableKeys.alcoholWithdrawal.localized
        resorptionDateView.titleLabel.text = Constants.LocalizableKeys.soberingDate.localized
        
        addButton.setTitle("+", for: .normal)
        addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        
        // Confirure alcohol service
        alcoholService = AlcoholStateService.shared
        alcoholService.delegate = self
        setupAlcoholState(alcoholService.alcoholState)
    }
    
    // MARK: Configuration
    private func configureNavBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = Constants.LocalizableKeys.state.localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(settingsTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    // MARK: Actions
    @objc private func settingsTapped(_ button: UIBarButtonItem) {
        SplashRouter.shared.showSettings()
    }
    
    @objc private func shareTapped() {
        let twitterAction = UIAlertAction(title: "Twitter", style: .default) { (action) in
            let twitterSharer = TwitterSharer(title: nil, image: UIImage(named: self.alcoholLevel?.imageName ?? ""))
            SharingService().share(with: twitterSharer)
        }
        
        let facebookAction = UIAlertAction(title: "Facebook", style: .default) { (action) in
            let facebookSharer = FacebookSharer(title: self.alcoholLevel?.link, image: nil)
            SharingService().share(with: facebookSharer)
        }
        
        let cancel = UIAlertAction(title: Constants.LocalizableKeys.cancel.localized, style: .cancel)
        
        AlertManager.sharedInstance.showActionSheet(title: Constants.LocalizableKeys.share.localized, message: nil, actions: [twitterAction, facebookAction, cancel])
    }
    
    @objc private func resetTapped() {
        AlertManager.sharedInstance.showAlertOkCancel(message: Constants.LocalizableKeys.areYouSure.localized, completionOk: {
            self.alcoholService.resetState()
        }, completionCancel: nil)
    }
    
    @objc private func addTapped(_ button: UIButton) {
        SplashRouter.shared.showDrinks()
    }
    
    // MARK: Private Methods
    private func setupAlcoholState(_ state: AlcoholState) {
        alcoholLevel = AlcoholLevel(value: state.concentration)
        
        headerView.concentrationValue = state.concentration
        
        let timestamp = Date().timeIntervalSince1970
        let delta = state.resorptionTimestamp - timestamp
        
        if  delta > 0 {
            let minutes = Int(round(delta / 60))
            
            resorptionTimeView.valueLabel.text = Constants.LocalizableKeys.inA.localized + " \(minutes) " + Constants.LocalizableKeys.minutes.localized
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, h:mm a"
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            
            let date = Date(timeIntervalSince1970: state.resorptionTimestamp)
            
            resorptionDateView.valueLabel.text = dateFormatter.string(from: date)
        }
    }
    
    private func setupLevel() {
        let hasLevel = alcoholLevel != nil
        
        navigationItem.rightBarButtonItem?.isEnabled = hasLevel
        headerView.stateView.backgroundColor = alcoholLevel?.color ?? .clear
        resetButton.isHidden = !hasLevel
        resorptionDateView.isHidden = !hasLevel
        resorptionTimeView.isHidden = !hasLevel
    }
}

extension DashboardViewController: AlcoholStateServiceDelegate {
    
    func didAlcoholStateUpdated(_ service: AlcoholStateService, state: AlcoholState) {
        setupAlcoholState(state)
    }
    
}
