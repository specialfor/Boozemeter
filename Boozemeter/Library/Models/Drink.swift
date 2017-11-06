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
        Drink(imageName: "vodka", title: Constants.LocalizableKeys.vodka.localized, turnover: 40, size: 50),
        Drink(imageName: "beer", title: Constants.LocalizableKeys.beer.localized, turnover: 5, size: 500),
        Drink(imageName: "champage", title: Constants.LocalizableKeys.champagne.localized, turnover: 11, size: 200),
        Drink(imageName: "cognac", title: Constants.LocalizableKeys.cognac.localized, turnover: 40, size: 40),
        Drink(imageName: "gin", title: Constants.LocalizableKeys.gin.localized, turnover: 40, size: 40),
        Drink(imageName: "liquer", title: Constants.LocalizableKeys.liquor.localized, turnover: 40, size: 40),
        Drink(imageName: "rum", title: Constants.LocalizableKeys.rum.localized, turnover: 40, size: 40),
        Drink(imageName: "tequila", title: Constants.LocalizableKeys.tequila.localized, turnover: 40, size: 40),
        Drink(imageName: "vermouth", title: Constants.LocalizableKeys.vermouth.localized, turnover: 18, size: 200),
        Drink(imageName: "whisky", title: Constants.LocalizableKeys.whiskey.localized, turnover: 40, size: 40),
        Drink(imageName: "wine", title: Constants.LocalizableKeys.wine.localized, turnover: 17, size: 200)]
}
