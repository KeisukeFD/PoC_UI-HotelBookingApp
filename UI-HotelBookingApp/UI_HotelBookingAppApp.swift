//
//  UI_HotelBookingAppApp.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI

@main
struct UI_HotelBookingAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FullScreenController())
        }
    }
}
