//
//  Order.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/22.
//

import Foundation

class Order:Identifiable,ObservableObject{
    internal init(sn: Int = Int.random(in: 50000...60000), date: Date, items: [Drink : Int], tax: Double) {
        self.sn = sn
        self.date = date
        self.items = items
        self.tax = tax
    }

    let id = UUID()
    var sn:Int
    var date:Date
    @Published var items:[Drink:Int]
    var tax:Double

    //汇率
    static var exchangeRates:Double = 1

}

extension Order {
    var list:[OrderItem]{
        items.keys.sorted(by: <).map{ drink in
            OrderItem(drink: drink, quantity: items[drink] ?? 0)
        }
    }

    var subTotal:Double{
        items.keys.map{ drink in
           drink.price * Double(items[drink] ?? 0)
        }.reduce(0, +) * Order.exchangeRates
    }

    var total:Double{
        subTotal * (1 + tax)
    }
    
    var totalQuantity:Int{
        items.values.reduce(0, +)
    }

    var totalCalories:Double{
        items.keys.map{ drink in
            drink.calories * Double(items[drink] ?? 0)
        }.reduce(0, +)
    }

    struct OrderItem:Identifiable,Hashable{
        var id:UUID{drink.id}
        let drink:Drink
        let quantity:Int

        var amount:Double{
            drink.price * Double(quantity)
        }
    }

    static let sampleOrder:Order = {
        let order = Order(date: Date(), items: [:], tax: 0.04)
        [.tea,.coffee,.tea,.juice].forEach{order.addItem($0)}
        return order
    }()
}

extension Order{
     func addItem(_ drink:Drink) {
        if let quantity = items[drink] {
            items[drink] = quantity + 1
        }
        else {
            items[drink] = 1
        }
    }

     func delItem(_ drink:Drink) {
        if let quantity = items[drink],quantity > 1 {
            items[drink] = quantity - 1
        }
        else {
            items[drink] = nil
        }
    }
}


