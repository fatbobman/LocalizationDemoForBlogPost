//
//  LocalizationDemoApp.swift
//  Shared
//
//  Created by Yang Xu on 2021/6/22.
//

import SwiftUI

@main
struct LocalizationDemoApp: App {
    @StateObject var order = Order(date: Date(), items: [:], tax: 0.05)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(order)
        }
    }
}
