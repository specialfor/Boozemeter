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
        let slider = SliderView(title: "Градус:", min: 1, max: 96, current: 12)
        
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
        let slider = SliderView(title: "Объем:", min: 1, max: 1000, current: 50)
        
        slider.formatString = "%@ мл."
        
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
        let slider = SliderView(title: "Сытость:", min: 0, max: 100, current: 30)
        
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
        let slider = SliderView(title: "Время:", min: 0, max: 300, current: 30)
        
        slider.formatString = "%@ минут назад"
        
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
        
        timeSlider.isHidden = false
        
        calculateButton.setTitle("Посчитать", for: .normal)
    }
    
}
