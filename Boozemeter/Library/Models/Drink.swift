//
//  Drink.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

struct Drink {
    let imageName: String
    let title: String
    let turnover: Int
    let size: Int
    
    static let drinks: [Drink] = [
        Drink(imageName: "vodka", title: "Водка", turnover: 40, size: 50),
        Drink(imageName: "wine", title: "Вино", turnover: 12, size: 150),
        ]
}
