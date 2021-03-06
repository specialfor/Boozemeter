//
//  InitialViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit
import SnapKit

class InitialViewController: ViewController {
    
    // MARK: Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.numberOfLines = 0
        
        let horizontalInset = 16.0
        
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(80.0)
            make.left.equalToSuperview().offset(horizontalInset)
            make.right.equalToSuperview().offset(-horizontalInset)
        })
        
        return label
    }()
    
    lazy var heightSlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.height.localized, min: 120, max: 210, current: 177)
        
        slider.formatString = Constants.LocalizableKeys.cm.localized
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            make.left.right.equalTo(titleLabel)
        })
        
        return slider
    }()
    
    lazy var weightSlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.weight.localized, min: 40, max: 200, current: 70)
        
        slider.formatString = Constants.LocalizableKeys.kg.localized
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(heightSlider.snp.bottom).offset(8.0)
            make.left.right.equalTo(heightSlider)
        })
        
        return slider
    }()
    
    lazy var sexSegment: SegmentControl = {
        let segment = SegmentControl()
        
        self.view.addSubview(segment)
        segment.snp.makeConstraints({ (make) in
            make.height.equalTo(60.0)
            
            make.top.equalTo(weightSlider.snp.bottom).offset(8.0)
            make.left.right.equalTo(weightSlider)
        })
        
        return segment
    }()
    
    lazy var nextButton: Button = {
        let button = Button()
        
        let inset = 16.0
        let height = 44.0
        let width = 100.0
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
            
            make.bottom.equalToSuperview().offset(-inset)
            make.right.equalToSuperview().offset(-inset)
        })
        
        return button
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = Constants.LocalizableKeys.enterData.localized
        
        sexSegment.titleLabel.text = Constants.LocalizableKeys.sex.localized
        sexSegment.itemTitles = [Sex.male.title, Sex.female.title]
        
        nextButton.setTitle(Constants.LocalizableKeys.next.localized, for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc private func nextTapped(_ button: UIButton) {
        var person = Person()
        person.height = Double(heightSlider.currentValue)
        person.weight = Double(weightSlider.currentValue)
        person.sex = Sex(rawValue: sexSegment.currentIndex) ?? .male
        
        StorageService.default.person = person
        SplashRouter.shared.showDashboard()
    }
    
}
