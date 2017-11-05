//
//  Sharer.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

protocol Sharer {
    
    var title: String? { get }
    var image: UIImage? { get }
    
    init(title: String?, image: UIImage?)
    
    func share()
    
}
