//
//  Data.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-22.
//

import Combine
import SwiftUI

class Data: ObservableObject {
    var objectWillChange = ObservableObjectPublisher()
    
    @Published var startDate: Date
    @Published var endDate: Date

    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
