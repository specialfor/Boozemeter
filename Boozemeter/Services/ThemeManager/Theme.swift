//
//  Theme.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

protocol Theme {
    
    var backgroundColor: UIColor { get }
    
    var mainColor: UIColor { get }
    var accentColor: UIColor { get }
    
    var textColor: UIColor { get }
    var selectedTextColor: UIColor { get }
    
    var darkGreyTextColor: UIColor { get }
    
    var lightGreyTextColor: UIColor { get }
    
}

extension Theme {
    
    var darkGreyTextColor: UIColor {
        return UIColor.darkGray
    }
    
    var lightGreyTextColor: UIColor {
        return UIColor.lightGray
    }
    
}
