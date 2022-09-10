//
//  URL+Extension.swift
//  GoodWeather
//
//  Created by Ibrahim on 9/10/22.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=e1a49befc5a89a4282fa9b19a663b7f6&units=imperial"
        return URL(string: urlString)
    }
}
