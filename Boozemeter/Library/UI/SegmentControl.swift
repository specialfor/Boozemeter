//
//  SegmentControl.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit
import TTSegmentedControl

class SegmentControl: View {
    
    var itemTitles: [String] = [] {
        didSet {
            segmentControl.itemTitles = itemTitles
        }
    }
    
    var currentIndex: Int {
        get {
            return segmentControl.currentIndex
        } set {
            segmentControl.selectItemAt(index: currentIndex, animated: false)
        }
    }
    
    var fontSize: CGFloat = 14.0 {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    var width: CGFloat = 120.0 {
        didSet {
            segmentControl.snp.makeConstraints { (make) in
                make.width.equalTo(width)
            }
        }
    }
    
    
    // MARK: Actions property
    private var target: Any?
    private var selector: Selector?
    
    // MARK: Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        let topInset = 8.0
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var segmentControl: TTSegmentedControl = {
        let segment = TTSegmentedControl()
        
        let theme = ThemeManager.shared.theme
        
        segment.containerBackgroundColor = theme.backgroundColor
        segment.defaultTextColor = theme.textColor
        segment.selectedTextColor = theme.selectedTextColor
        segment.thumbColor = theme.mainColor
        segment.useGradient = false
        segment.cornerRadius = 6.0

        let inset = 8.0
        
        self.addSubview(segment)
        segment.snp.makeConstraints({ (make) in
            make.width.equalTo(width)
            
            make.left.equalTo(titleLabel.snp.right).offset(inset)
            make.top.equalToSuperview().offset(inset)
            make.right.equalToSuperview().offset(-inset)
            make.bottom.equalToSuperview().offset(-inset)
        })
        
        return segment
    }()
    
    // MARK: Setup
    override func baseSetup() {
        segmentControl.isHidden = false
        
        segmentControl.didSelectItemWith = { [unowned self] (index, title) in
            if let object = self.target as? NSObject {
                object.perform(self.selector, with: self)
            }
        }
    }
    
    // MARK: Actions
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        if (controlEvents == .valueChanged) {
            self.target = target
            self.selector = action
        }
    }
    
}
