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
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = ThemeManager.shared.theme.mainColor
        
        button.layer.cornerRadius = 6.0
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        
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
        
        self.view.backgroundColor = UIColor.white
        
        titleLabel.text = "Введите персональные данные"
        
        sexSegment.titleLabel.text = "Пол:"
        sexSegment.itemTitles = ["Муж.", "Жен."]
        sexSegment.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        
        nextButton.setTitle("Вперед", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc private func valueChanged(_ segment: SegmentControl) {
        print("Current selected index: \(segment.currentIndex)")
    }
    
    @objc private func nextTapped(_ button: UIButton) {
        // TODO: Open Main Screen
        print("next tapped")
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
