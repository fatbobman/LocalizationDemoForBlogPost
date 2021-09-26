//
//  PriceView.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/22.
//

import Foundation
import SwiftUI

struct PriceView: View {
    @EnvironmentObject var order: Order
    @Environment(\.locale) var locale

    private func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        if locale.identifier != "zh_CN" {
            formatter.locale = Locale(identifier: "en-us")
        }
        return formatter
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("subtotal")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(NSNumber(value: order.subTotal), formatter: currencyFormatter())
                        .frame(maxWidth: .infinity)
                }
                HStack {
                    Text("tax rate")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(order.tax.formatted(.percent))
                        .frame(maxWidth: .infinity)
                }
                HStack(alignment: .bottom) {
                    Text("total")
                        .font(.title2)
                        .foregroundColor(.pink)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(NSNumber(value: order.total), formatter: currencyFormatter())
                        .frame(maxWidth: .infinity)
                }
            }
            .textCase(.uppercase)
            .frame(maxWidth: 200)
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct PriceViewPreview: PreviewProvider {
    static var previews: some View {
        PriceView()
            .previewLayout(.sizeThatFits)
            .environmentObject(Order.sampleOrder)

        PriceView()
            .previewLayout(.sizeThatFits)
            .environmentObject(Order.sampleOrder)
            .environment(\.locale, .init(identifier: "zh"))
    }
}
