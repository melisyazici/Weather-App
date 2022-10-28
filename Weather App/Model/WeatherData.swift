//
//  WeatherData.swift
//  Weather App
//
//  Created by Melis Yazıcı on 10.05.22.
//

import Foundation

struct WeatherData: Codable {
    let name:String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp:Double
}

struct Weather: Codable {
    let id:Int
}

//print(decodedData.main.temp)
//print(decodedData.weather[0].description)
