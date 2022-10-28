//
//  WeatherModel.swift
//  Weather App
//
//  Created by Melis Yazıcı on 10.05.22.
//

import Foundation

struct WeatherModel {
    let conditionId:Int
    let cityName: String
    var temperature:Double
    
    //computed property
    var temperatureString:String {
         return String(format: "%.1f", temperature)
    }
    
    //computed property
    var conditinName:String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
}
