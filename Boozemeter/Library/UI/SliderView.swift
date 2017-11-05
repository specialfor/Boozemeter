//
//  SliderView.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SliderView: View {
    
    private(set) var formatter: NumberFormatter!
    
    var formatString: String? {
        didSet {
            setCurrentValue(currentValue)
        }
    }
    
    var fontSize: CGFloat = 14.0 {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
            valueLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    // MARK: Values
    var minValue: Float {
        get {
            return sliderView.minimumValue
        }
        set {
            sliderView.minimumValue = newValue
        }
    }
    
    var maxValue: Float {
        get {
            return sliderView.maximumValue
        }
        set {
            sliderView.maximumValue = newValue
        }
    }
    
    var currentValue: Float {
        get {
            return sliderView.value
        }
        set {
            setCurrentValue(newValue)
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
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: CGRect.zero)
        
        self.fontSize = fontSize
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        
        self.titleLabel.text = title
    }
    
    convenience init(title: String, min: Float, max: Float, current: Float) {
        self.init(title: title)
        
        setValues(min: min, max: max, current: current)
    }
    
    private func setValues(min: Float, max: Float, current: Float) {
        self.minValue = min
        self.maxValue = max
        self.currentValue = current
    }
    
    // MARK: Setup
    override func baseSetup() {
        formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        sliderView.tintColor = theme.mainColor
        sliderView.minimumValue = 0
        sliderView.maximumValue = 100
        sliderView.value = 50
        
        sliderView.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: Actions
    @objc private func valueChanged(_ slider: UISlider) {
        setCurrentValue(slider.value)
    }
    
    private func setCurrentValue(_ value: Float) {
        let tempValue = round(value)
        
        sliderView.value = tempValue
        
        let formatString = self.formatString ?? "%@"
        let numberString = formatter.string(from: NSNumber(value: tempValue)) ?? ""
        valueLabel.text = String(format: formatString, numberString)
    }
}

