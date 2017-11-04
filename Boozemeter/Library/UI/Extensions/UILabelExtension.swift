//
//  UILabelExtension.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

extension UILabel {
 
    convenience init(textColor: UIColor, fontSize: CGFloat, weight: UIFont.Weight = .medium) {
        self.init(frame: CGRect.zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
    }
    
}
