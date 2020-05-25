//
//  File.swift
//  WeatherApp
//
//  Created by calum boustead on 26/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import Foundation

struct WeatherData {
    
    var weather = [LocalWeatherData]()
    var unitCelcius = true
    
    static var weatherData = WeatherData()
    
}

struct LocalWeatherData: Codable {
    
    var index: Int?
    var location: String?
    let lon: Float?
    let lat: Float?
    let timezone: String?
    let current: CurrentWeatherInfo?
    let hourly: [HourlyWeatherInfo]?
    let daily: [DailyWeatherInfo]?
}

struct CurrentWeatherInfo: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Float?
    let feels_like: Float?
    let pressure: Int?
    let humidity: Int?
    let uvi: Float?
    let clouds: Int?
    let visibility: Int?
    let wind_speed: Float?
    let wind_deg: Int?
    let weather: [CurrentWeather]?
}

struct CurrentWeather: Codable {
    let main: String?
    let description: String?
}


struct HourlyWeatherInfo: Codable {
    let dt: Int?
    let temp: Float?
    let weather: [HourlyWeather]?
}

struct HourlyWeather: Codable {
    let main: String?
    let description: String?
}

struct DailyWeatherInfo: Codable {
    let dt: Int?
    let temp: DailyWeatherTemp?
    let weather: [DailyWeather]?
}

struct DailyWeatherTemp: Codable {
    let min: Float?
    let max: Float?
}

struct DailyWeather: Codable {
    let main: String?
    let description: String?
}
