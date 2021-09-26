//
//  Drink.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/22.
//

import Foundation
import SwiftUI

struct Drink:Identifiable,Hashable,Comparable{
    internal init(name: String, price: Double, calories: Double) {
        self.name = String.localizedStringWithFormat(NSLocalizedString(name, comment: name))
        self.price = price
        self.calories = calories
//        self.localName = localName
//        self.localName
    }

    static func < (lhs: Drink, rhs: Drink) -> Bool {
//        lhs.name.stringValue() < rhs.name.stringValue()
//        lhs.name < rhs.name
        NSLocalizedString(lhs.name,comment: "") < NSLocalizedString(rhs.name,comment: "")
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()
    var name:String
    let price:Double
    let calories:Double
//    let localName:

    //初始按照美元定价，热量时随便填的
    static let juice = Drink(name: "Orange Juice", price: 4.5,calories: 120)
    static let tea = Drink(name: "Tea", price: 4.5,calories: 30)
    static let coffee = Drink(name: "Coffee", price: 4.2,calories: 83)
    static let coke = Drink(name: "Coke", price: 3.5,calories: 120)
    static let sprite = Drink(name: "Sprite", price: 3.5,calories: 120)

    static let allDrinks:[Drink] = [.juice,.tea,.coke,.coffee,.sprite].sorted(by: <)
}


extension LocalizedStringKey {
    var stringKey: String {
        let description = "\(self)"
        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }
        return components[1][0]
    }
}

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        let localizedString = NSLocalizedString(key, bundle: Bundle.main, comment: "")
        return localizedString
    }
}

extension LocalizedStringKey {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey, locale: locale)
    }
}
