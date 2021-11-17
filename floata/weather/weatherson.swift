//
//  weatherson.swift
//  floting
//
//  Created by 홍태희 on 2021/11/08.
//

import Foundation

// API로부터 받을 값을 저장한 모델
struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
