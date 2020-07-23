//
//  HotelCard.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI

struct HotelCard: View {
    let hotel: Hotel

    private let boldFont: Font = Font.system(.body).bold()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image("\(hotel.image)")
                    .resizable()
                    .scaledToFit()
                
                Button(action: {}) {
                    Image(systemName: "heart")
                        .font(boldFont)
                        .foregroundColor(.accentColor)
                        .padding(.all, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                }.padding(.all, 10)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(hotel.name)")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Text("\(hotel.city)")
                            .foregroundColor(Color("defaultColor"))
                            .font(.caption)
                            .padding(.trailing)
                        
                        Image(systemName: "mappin.and.ellipse")
                            .font(Font.caption)
                            .foregroundColor(.accentColor)

                        Text("\(String(format: "%.f", hotel.nearestCityDistance)) km to city")
                            .foregroundColor(Color("defaultColor"))
                            .font(.caption)

                    }
                    
                    HStack(spacing: 15) {
                        StarsView(total: 5, score: hotel.score)
                            .font(.caption)
                        Text("\(hotel.review) Reviews")
                            .foregroundColor(Color("defaultColor"))
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("$\(String(format: "%.f", hotel.price))")
                        .font(.title2)
                        .bold()

                    Text("/per night")
                        .font(.caption)
                        .foregroundColor(Color("defaultColor"))
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color("lightGray"), radius: 10, y: 15)
    }
}

struct HotelCard_Previews: PreviewProvider {
    static var previews: some View {
        HotelCard(hotel: hotels[0])
    }
}
