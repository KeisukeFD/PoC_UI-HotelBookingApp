//
//  RoundedButton.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-22.
//

import SwiftUI

struct RoundedButton: View {
    var value: String
    
    var color: Color = .white
    var backgroundColor: Color = .accentColor
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: self.action) {
                Text("\(self.value)")
                    .foregroundColor(self.color)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(self.backgroundColor)
                    .cornerRadius(30)
            }
        }
        
        .padding()
        
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(value: "Apply") {
            print("Clicked")
        }
    }
}
