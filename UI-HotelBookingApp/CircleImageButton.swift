//
//  CircleImageButton.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI

struct CircleImageButton: View {
    var action: () -> Void
    var systemName: String

    var body: some View {
        Button(action: action) {
            Image(systemName: self.systemName)
                .foregroundColor(Color("defaultColor"))
                .opacity(0.6)
                .padding()
                .frame(width: 30, height: 30)
                .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 1.0)
                            .fill(Color("defaultColor"))
                )
        }
    }
}
