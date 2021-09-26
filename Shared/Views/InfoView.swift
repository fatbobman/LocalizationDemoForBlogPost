//
//  InfoView.swift
//  LocalizationDemo
//
//  Created by Yang Xu on 2021/6/23.
//

import Foundation
import SwiftUI


struct InfoView:View {
    @EnvironmentObject var order:Order
    @Environment(\.presentationMode) var presentationMode
    var list:String {
        order.list.map{NSLocalizedString($0.drink.name, comment: "")}.formatted(.list(type: .and))
    }
    var body: some View{
        NavigationView{
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100)
                HStack{
                    Text("Items:")
                    Text(list)
                }
                HStack{
                    Text("Energy:")
                    Text("\(Int(order.totalCalories))")
                }
                Text(saying)
            }
            .toolbar{
                ToolbarItem{
                    ControlGroup{
                        Button("Close"){presentationMode.wrappedValue.dismiss()}
                    }
                }
            }
            .navigationTitle("Summary")
        }
    }

    var saying:AttributedString{
        guard let url = Bundle.main.url(forResource: "saying", withExtension: "md")
        else {
            return .init()
        }
        return  (try? AttributedString(contentsOf: url,  baseURL: nil)) ?? .init()
    }
}

struct InfoViewPreview:PreviewProvider{
    static var previews: some View{
        InfoView()
            .environmentObject(Order.sampleOrder)
            .environment(\.locale, .init(identifier: "zh"))
        
        InfoView()
            .environmentObject(Order.sampleOrder)


    }
}
