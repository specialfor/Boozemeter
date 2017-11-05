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
        Drink(imageName: "beer", title: "Пиво", turnover: 5, size: 500),
        Drink(imageName: "champage", title: "Шампанское", turnover: 11, size: 200),
        Drink(imageName: "cognac", title: "Коньяк", turnover: 40, size: 40),
        Drink(imageName: "gin", title: "Джин", turnover: 40, size: 40),
        Drink(imageName: "liquer", title: "Ликёр", turnover: 40, size: 40),
        Drink(imageName: "rum", title: "Ром", turnover: 40, size: 40),
        Drink(imageName: "tequila", title: "Текила", turnover: 40, size: 40),
        Drink(imageName: "vermouth", title: "Вермут", turnover: 18, size: 200),
        Drink(imageName: "whisky", title: "Виски", turnover: 40, size: 40),
        Drink(imageName: "wine", title: "Вино", turnover: 17, size: 200)]
}
