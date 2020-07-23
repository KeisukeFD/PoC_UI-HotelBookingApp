//
//  ContentView.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var fullScreen: FullScreenController
    
    init() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = UIColor.white
        standardAppearance.shadowColor = .clear
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = UIColor.white
        compactAppearance.shadowColor = .clear
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = UIColor.white
        scrollEdgeAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().compactAppearance = compactAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
    @State var data = Data(startDate: Date().addDay(7), endDate: Date().addDay(14))
    
    var body: some View {
        FullScreenView(content: {
            NavigationView {
                MainView(data: data)
                    .environmentObject(fullScreen)
            }
        }).environmentObject(fullScreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
