//
//  ItemListView.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/23.
//

import Foundation
import SwiftUI

struct ItemsListView:View{
    @EnvironmentObject var order:Order
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        NavigationView{
            List(Drink.allDrinks) { drink in
                Button(LocalizedStringKey(drink.name)){
                    order.addItem(drink)
                }.disabled(order.items.keys.contains(drink))
            }
            .toolbar{
                ToolbarItem{
                    ControlGroup{
                        Button("Close"){presentationMode.wrappedValue.dismiss()}
                    }
                }
            }
            .navigationTitle("Add Item")
        }

        .navigationViewStyle(.stack)
    }
}

struct ItemListPreview:PreviewProvider{
    static var previews: some View{
        ItemsListView()
            .environmentObject(Order.sampleOrder)
            .environment(\.locale, .init(identifier: "zh"))
        
        ItemsListView()
            .environmentObject(Order.sampleOrder)


    }
}
