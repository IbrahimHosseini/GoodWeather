//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by Ibrahim on 9/10/22.
//

import Foundation

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}


struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    static var empty: WeatherResult {
        WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}
