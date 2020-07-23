//
//  SearchFieldView.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var query: String

    let boldFont: Font = Font.system(.body).weight(.bold)
    
    var body: some View {
        HStack {
            TextField("Search", text: $query)
                .padding(.all, 14)
                .background(Color.white)
                .cornerRadius(80)
                .shadow(radius: 10, y: 4)

            Spacer()
            
            Button(action: {
                
            }) {
                Image(systemName: "magnifyingglass")
                    .font(boldFont)
                    .foregroundColor(.white)
                    .padding(.all)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .shadow(radius: 10, x: 4, y: 4)
            }
            
        }.padding(.all)
    }
}
