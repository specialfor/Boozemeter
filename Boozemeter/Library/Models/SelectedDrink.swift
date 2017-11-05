//
//  SelectedDrink.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

struct SelectedDrink {
    var turnover: Double // in segment [0, 1]
    var size: Int // ml.
    var satiety: Double // in segment [0, 1]
    var time: Int // in minutes
    
    init() {
        turnover = 0.01
        size = 40
        satiety = 30
        time = 30
    }
}
