//
//  ContentView.swift
//  Shared
//
//  Created by Yang Xu on 2021/6/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var order:Order
    @State var showItemList = false
    @State var showPayResult = false
    var body: some View {
        VStack{
            title
                .padding(.vertical)
            ScrollView{
                TableView()
            }
            PriceView()
            ButtonView(showItemsList: $showItemList,showPayResult: $showPayResult)
            Spacer()
        }
        .padding(.horizontal)
        .sheet(isPresented: $showItemList){ItemsListView().environmentObject(order)}
        .sheet(isPresented: $showPayResult){InfoView().environmentObject(order)}
        .task {
            let orders:[Drink] = [.tea,.coffee,.tea,.juice]
            orders.forEach{order.addItem($0)}
        }
        #if os(macOS)
        .scenePadding()
        #endif
    }

    var title: some View{
        HStack(alignment: .bottom){
            Text("FatbobBar")
                .font(.title)
            Spacer()
            Text(order.date,style: .date)
            Text(order.date.formatted(.dateTime.weekday()))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Order.sampleOrder)
            .environment(\.locale, .init(identifier: "zh"))
        
        ContentView()
            .environmentObject(Order.sampleOrder)
    }
}





