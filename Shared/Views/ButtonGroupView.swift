//
//  ButtonGropuView.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/23.
//  www.fatbobman.com

import Foundation
import SwiftUI


struct ButtonView:View{
    @EnvironmentObject var order:Order
    @Binding var showItemsList:Bool
    @Binding var showPayResult:Bool
    var body: some View{
        HStack{
            Button {
                showItemsList.toggle()
            }
            label : {
                Text("Tap add item")
            }

            Button {
                showPayResult.toggle()
            } label: {
                Text("Pay for \(order.totalQuantity) drinks")
            }
            .buttonStyle(.borderedProminent)
        }
        .buttonStyle(.bordered)
    }
}

struct ButtonViewPreview:PreviewProvider{
    static var previews: some View{
        ButtonView(showItemsList: .constant(false),showPayResult: .constant(false))
            .environmentObject(Order.sampleOrder)
            .padding()
            .previewLayout(.sizeThatFits)

        ButtonView(showItemsList: .constant(false),showPayResult: .constant(false))
            .environmentObject(Order.sampleOrder)
            .padding()
            .previewLayout(.sizeThatFits)
            .environment(\.locale, .init(identifier: "zh"))
    }
}
