//
//  Calendar.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-22.
//

import SwiftUI

struct Days: Identifiable {
    var id: UUID = UUID()
    var number: String
    var date: Date
    var currentMonth: Bool
}
