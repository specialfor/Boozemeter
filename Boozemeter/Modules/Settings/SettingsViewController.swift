//
//  SettingsViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/6/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SettingsViewController: ViewController {
    
    // MARK: Views
    lazy var heightSlider: SliderView = {
        let slider = SliderView(title: Constants.LocalizableKeys.height.localized, min: 120, max: 210, current: 177)
        
        slider.formatString = Constants.LocalizableKeys.cm.localized
        
        let inset = 16.0
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(32.0)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
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
    //
    
    lazy var touchIdSegment: SegmentControl = {
        let segment = SegmentControl()
        
        self.view.addSubview(segment)
        segment.snp.makeConstraints({ (make) in
            make.height.equalTo(60.0)
            
            make.top.equalTo(sexSegment.snp.bottom).offset(8.0)
            make.left.right.equalTo(weightSlider)
        })
        
        return segment
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constants.LocalizableKeys.settings.localized
        
        configureHeightSlider()
        configureWeightSlider()
        configureSexSegment()
        configureTouchIdSegment()
    }
    
    // MARK: Configure
    private func configureHeightSlider() {
        heightSlider.addTarget(self, action: #selector(heightChanged), for: .valueChanged)
        
        heightSlider.currentValue = Float(StorageService.default.person!.height)
    }
    
    private func configureWeightSlider() {
        weightSlider.addTarget(self, action: #selector(weightChanged), for: .valueChanged)
        
        weightSlider.currentValue = Float(StorageService.default.person!.weight)
    }

    private func configureSexSegment() {
        sexSegment.titleLabel.text = Constants.LocalizableKeys.sex.localized
        sexSegment.itemTitles = [Sex.male.title, Sex.female.title]
        sexSegment.addTarget(self, action: #selector(sexChanged), for: .valueChanged)
        
        sexSegment.segmentControl.isHidden = false
        sexSegment.layoutIfNeeded()
        
        sexSegment.currentIndex = StorageService.default.person!.sex.rawValue
    }
    
    private func configureTouchIdSegment() {
        touchIdSegment.titleLabel.text = Constants.LocalizableKeys.useTouchId.localized
        touchIdSegment.itemTitles = [Constants.LocalizableKeys.no.localized, Constants.LocalizableKeys.yes.localized]
        touchIdSegment.addTarget(self, action: #selector(touchIdChanged), for: .valueChanged)
        
        touchIdSegment.segmentControl.isHidden = false
        touchIdSegment.layoutIfNeeded()
        
        touchIdSegment.currentIndex = StorageService.default.shouldUseTouchId ? 1 : 0
    }
    
    // MARK: Actions
    @objc private func heightChanged(_ sliderView: SliderView) {
        StorageService.default.person?.height = Double(sliderView.currentValue)
        AlcoholStateService.shared.recalculateState()
    }
    
    @objc private func weightChanged(_ sliderView: SliderView) {
        StorageService.default.person?.weight = Double(sliderView.currentValue)
        AlcoholStateService.shared.recalculateState()
    }
    
    @objc private func sexChanged(_ segmentControl: SegmentControl) {
        StorageService.default.person?.sex = Sex(rawValue: segmentControl.currentIndex) ?? .male
        AlcoholStateService.shared.recalculateState()
    }
    
    @objc private func touchIdChanged(_ segmentControl: SegmentControl) {
        let index = segmentControl.currentIndex
        
        if index == 1 {
            let auth = LocalAuthService()
            
            if auth.canAuth(with: .passcode) {
                StorageService.default.shouldUseTouchId = true
            } else {
                segmentControl.currentIndex = 0
            }
        } else {
            StorageService.default.shouldUseTouchId = false
        }
    }
    
}
