//
//  TableView.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/22.
//

import Foundation
import SwiftUI

struct TableView:View{
    @EnvironmentObject var order:Order
    var body: some View{
        VStack(spacing:0){
            header
            if !order.list.isEmpty {
                VStack{
                    ForEach(order.list) { item in
                        ItemRowView(item:item)
                        Divider()
                    }
                }
                .padding(.top,10)
                .frame(minHeight:100,maxHeight: 300,alignment: .top)
            }
            else {
                Text("Empty")
                    .frame(minHeight:200)

            }

        }
    }

    var header: some View{
        HStack{
            Text("Item")
                .frame(maxWidth:.infinity)
            Text("Quantity")
                .frame(maxWidth:.infinity)
            Text("Unit Price")
                .frame(maxWidth:.infinity)
            Text("Amount")
                .frame(maxWidth:.infinity)
        }
        .foregroundStyle(.primary)
        .textCase(.uppercase)
        .font(.body.bold())
        .padding(.vertical)
        .background(Color.cyan.opacity(0.8).frame(height:50))
    }
}

struct ItemRowView:View{
    let item:Order.OrderItem
    @EnvironmentObject var order:Order
    var body: some View{
        HStack{
            Text(LocalizedStringKey(item.drink.name))
//            Text(item.drink.localName)
                .padding(.leading,20)
                .frame(maxWidth:.infinity,alignment: .leading)
            HStack(spacing:3){
                Button{
                    withAnimation{
                        order.addItem(item.drink)
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")

                }
                .buttonStyle(.borderless)
                Text("\(item.quantity)")
                Button{
                    withAnimation{
                        order.delItem(item.drink)
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")

                }
                .buttonStyle(.borderless)
            }
            .monospacedDigit()
            .frame(maxWidth:.infinity)
            Text("\(String(format:"%.2f",item.drink.price * Order.exchangeRates))")
                .frame(maxWidth:.infinity)
            Text("\(String(format:"%.2f",item.amount))")
                .frame(maxWidth:.infinity)
        }
    }
}

struct TableViewPreview:PreviewProvider{
    static var previews: some View{
        TableView()
            .environmentObject(Order.sampleOrder)
            .previewLayout(.sizeThatFits)

        TableView()
            .environmentObject(Order.sampleOrder)
            .previewLayout(.sizeThatFits)
            .environment(\.locale,Locale(identifier: "zh"))

        TableView()
            .environmentObject(Order(date: Date(), items: [:], tax: 0.05))
            .previewLayout(.sizeThatFits)

    }
}
