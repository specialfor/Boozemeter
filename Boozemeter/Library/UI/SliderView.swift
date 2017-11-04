//
//  SliderView.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SliderView: UIView {
    
    var fontSize: CGFloat = 14.0 {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
            valueLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    // MARK: Values
    var minValue: Float = 0 {
        didSet {
            sliderView.minimumValue = minValue
        }
    }
    
    var maxValue: Float = 100 {
        didSet {
            sliderView.maximumValue = maxValue
        }
    }
    
    var currentValue: Float = 50 {
        didSet {
            sliderView.value = currentValue
            valueLabel.text = String(currentValue)
        }
    }
    
    // MARK: Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        let topInset = 8.0
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(topInset)
            make.left.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .right
        
        let leftInset = 8.0
        let topInset = 8.0
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLabel.snp.top)
            make.height.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(leftInset)
            make.right.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var sliderView: UISlider = {
        let slider = UISlider()
        
        let verticalInset = 8.0
        
        self.addSubview(slider)
        slider.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalInset)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(valueLabel.snp.right)
            make.bottom.equalToSuperview().offset(-verticalInset)
        })
        
        return slider
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: CGRect.zero)
        
        self.fontSize = fontSize
    }
    
    // MARK: Setup
    private func baseSetup() {
        sliderView.isHidden = false
        
        sliderView.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: Actions
    @objc private func valueChanged(_ slider: UISlider) {
        sliderView.value = round(slider.value)
        valueLabel.text = String(slider.value)
    }
}

