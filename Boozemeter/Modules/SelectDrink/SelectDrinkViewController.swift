//
//  SelectDrinkViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SelectDrinkViewController: ViewController {
    
    var drink: Drink! {
        didSet {
            navigationItem.title = drink.title
            
            drinkView.imageView.image = UIImage(named: drink.imageName)
            turnoverSlider.currentValue = Float(drink.turnover)
            sizeSlider.currentValue = Float(drink.size)
        }
    }
    
    // MARK: Views
    lazy var drinkView: DrinkView = {
        let view = DrinkView()
        
        let inset = 16.0
        
        self.view.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.height.width.equalTo(90.0)
            
            make.top.equalTo(inset)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return view
    }()
    
    lazy var turnoverSlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.degree.localized, min: 1, max: 96, current: 12)
        
        slider.formatString = "%@ %%"
        
        let inset = 16.0
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(drinkView.snp.bottom).offset(inset * 0.5)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return slider
    }()
    
    lazy var sizeSlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.volume.localized, min: 1, max: 1000, current: 50)
        
        slider.formatString = Constants.LocalizableKeys.ml.localized
        
        let inset = 16.0
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(turnoverSlider.snp.bottom).offset(inset * 0.5)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return slider
    }()
    
    lazy var satietySlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.satiety.localized, min: 0, max: 100, current: 30)
        
        slider.formatString = "%@ %%"
        
        let inset = 16.0
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(sizeSlider.snp.bottom).offset(inset * 0.5)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return slider
    }()
    
    lazy var timeSlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.time.localized, min: 0, max: 300, current: 30)
        
        slider.formatString = Constants.LocalizableKeys.minutesAgo.localized
        
        let inset = 16.0
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(satietySlider.snp.bottom).offset(inset * 0.5)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return slider
    }()
    
    lazy var calculateButton: Button = {
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
        
        timeSlider.isHidden = true
        
        calculateButton.setTitle(Constants.LocalizableKeys.countUp.localized, for: .normal)
        calculateButton.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc private func calculateTapped() {
        var drink = SelectedDrink()
        drink.turnover = Double(turnoverSlider.currentValue / 100.0)
        drink.size = Int(sizeSlider.currentValue)
        drink.satiety = Double(satietySlider.currentValue / 100.0)
        drink.time = Int(timeSlider.currentValue)
        
        AlcoholStateService.shared.updateStateWith(drink: drink)
        
        SplashRouter.shared.dismissToDashboard()
    }
    
}
