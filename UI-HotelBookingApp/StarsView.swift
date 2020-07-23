//
//  StarsView.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI

struct StarsView: View {
    var total: Int = 5
    var score: Float = 2.5
    
    var body: some View {
        HStack {
            ForEach(0..<total) { i in
                let decimal = (score-Float(i)) * 100
                if(i < Int(floor(score))) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.accentColor)
                } else if( decimal > 0 && decimal < 100 ) {
                    Image(systemName: "star.lefthalf.fill")
                        .foregroundColor(.accentColor)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
