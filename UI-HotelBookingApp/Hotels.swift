//
//  Hotels.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//

import SwiftUI

struct Hotel {
    var image: String
    var name: String
    var city: String
    var nearestCityDistance: Float
    var review: Int
    var score: Float
    var price: Float
}

let hotels = [
    Hotel(image: "hotel_1", name: "Grand Royal Hotel", city: "Wembley, London", nearestCityDistance: 2, review: 80, score: 4, price: 180),
    Hotel(image: "hotel_2", name: "Queen Hotel", city: "Wembley, London", nearestCityDistance: 2, review: 89, score: 3.7, price: 220),
    Hotel(image: "hotel_3", name: "Grand Hotel", city: "Sussex, London", nearestCityDistance: 5.6, review: 114, score: 4.3, price: 389),
    
]
