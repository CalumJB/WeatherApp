//
//  DataHelper.swift
//  WeatherApp
//
//  Created by calum boustead on 03/05/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import Foundation
import UIKit

func weathericon(main: String) -> UIImage {
    switch main {
    case "Clear":
        return UIImage(named: "clear_color")!
    case "Clouds":
        return UIImage(named:"few_clouds_color")!
    case "Rain":
        return UIImage(named: "shower_rain")!
    case "Snow":
        return UIImage(named: "snow")!
    case "Thunderstorm":
        return UIImage(named: "thunderstorm")!
    default:
        return UIImage(named: "mist")!
    }
}

func tempToMetricorImperial(unitTemp: Float) -> String {
    if(WeatherData.weatherData.unitCelcius){
        return String(Int(unitTemp - 273.152)) + "°"
    } else {
        return String(Int(unitTemp * (9/5) - 459.67)) + "°"
    }
}

func getHour(unixTime: Int) -> String {
    let date = Date(timeIntervalSince1970: Double(unixTime))
    let calendar = Calendar.current
    return String(calendar.component(.hour, from: date))
}

func getWeekDay(unixTime: Int) -> String {
    let date = Date(timeIntervalSince1970: Double(unixTime))
    let calendar = Calendar.current
    let weekday = calendar.component(.weekday, from: date)
    switch weekday {
    case 1:
        return "Monday"
    case 2:
        return "Tuesday"
    case 3:
        return "Wednesday"
    case 4:
        return "Thursday"
    case 5:
        return "Friday"
    case 6:
        return "Saturday"
    default:
        return "Sunday"
    }
}

func getTime(unixTime: Int) -> String {
    let date = Date(timeIntervalSince1970: Double(unixTime))
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    return String(hour) + ":" + String(minute)
}


