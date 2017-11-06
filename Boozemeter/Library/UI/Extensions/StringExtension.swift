//
//  StringExtension.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/6/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
