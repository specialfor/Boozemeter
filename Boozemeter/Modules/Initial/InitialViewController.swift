//
//  InitialViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {
    
    // MARK: Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0
        
        let horizontalInset = 16.0
        
        self.view.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(horizontalInset)
            make.right.equalToSuperview().offset(-horizontalInset)
        })
        
        return label
    }()
    
    lazy var heightSlider: SliderView = {
        let slider = createSlider(with: "Рост:", min: 120, max: 210, current: 177)
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.right.equalTo(titleLabel)
        })
        
        return slider
    }()
    
    lazy var weightSlider: SliderView = {
        let slider = createSlider(with: "Вес:", min: 40, max: 200, current: 70)
        
        self.view.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(heightSlider.snp.bottom).offset(8.0)
            make.left.right.equalTo(heightSlider)
            make.bottom.equalToSuperview().offset(-16.0)
        })
        
        return slider
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        titleLabel.text = "Введите персональные данные"
        weightSlider.isHidden = false
    }
    
    // MARK: Private methods
    private func createSlider(with title: String, min: Float, max: Float, current: Float) -> SliderView {
        let slider = SliderView()
        
        slider.titleLabel.text = title
        slider.minValue = min
        slider.maxValue = max
        slider.currentValue = current
        
        return slider
    }
}
