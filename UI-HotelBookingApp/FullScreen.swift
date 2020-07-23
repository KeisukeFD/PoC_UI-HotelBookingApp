//
//  FullScreen.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-22.
//

import SwiftUI

class FullScreenController: ObservableObject {
    @Published var isIt: Bool
    @Published var content: AnyView? = nil

    init(show: Bool = false) {
        self.isIt = show
    }
    
    func show(@ViewBuilder content: () -> AnyView) {
        self.isIt = true
        self.content = content()
    }

    func hide() {
        self.isIt = false
    }
}

struct FullScreenView<Content>: View where Content: View {
    @EnvironmentObject var fullScreen: FullScreenController
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if let fullScreenContent = self.fullScreen.content, self.fullScreen.isIt {
            ZStack {
                self.content
                    .zIndex(0)
                    .blur(radius: 10)
                    .onTapGesture {
                        withAnimation {
                            self.fullScreen.hide()
                        }
                    }
                
                fullScreenContent
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }.edgesIgnoringSafeArea(.all)
        } else {
            self.content
        }
    }
}
