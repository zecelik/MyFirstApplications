//
//  Weather.swift
//  WeatherApp
//
//  Created by Zehra on 10.10.2024.
//

import Foundation

struct Weather: Codable {
    let main: Main
    let weather: [WeatherDetails]
}

struct Main: Codable {
    let temp: Double
}

struct WeatherDetails: Codable {
    let description: String
}
