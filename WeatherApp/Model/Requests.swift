//
//  Requests.swift
//  WeatherApp
//
//  Created by calum boustead on 01/05/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import Foundation


func doRequestForAutocomplete(urlString: String, array: [String],  completion: @escaping (LocationData) -> Void) {
    
    guard let url = URL(string: urlString) else {
               print("URL conversion failed")
               return
           }

           //do request
           URLSession.shared.dataTask(with: url) { (data, response, err) in
               //if there was an error
               if(err != nil){
                   print(err!.localizedDescription)
               
               //if ok
               }else{
                   //get data as string
                   let str = String(decoding: data!, as: UTF8.self)
                   
                   //check no error response
                   if str.range(of:"error_message") != nil {
                       print("error:" + str)
                       return
                   }
                   
                   //get values
                   print("res:" + str)
                   do {
                       
                       let jsonLoc = try JSONDecoder().decode(LocationData.self, from: data!)
                    
                       completion(jsonLoc)
                       
                       
                   } catch let err {
                       print("Error serializing json", err)
                   }
               }
           }.resume()
}

// Function to get the geometry and weather data when a cell is clicked

func doRequestForGeomery(address: String, nameOfLocation: String, completion: @escaping () -> Void) {
    
    //create url
    let key = "AIzaSyAHBr0CijiFUOXaiMkbOPHIsfhCp_tXkFA"
    let urlString = "https://maps.googleapis.com/maps/api/geocode/json?"
        + "address=" + address
        + "&key=" + key
    
    // Create url from string
    guard let url = URL(string: urlString) else { return }
    
    // do a GET request for coordinate information
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        if err == nil {
            // Check that the roponse code is OK
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if 200...299 ~= httpResponse.statusCode {
                
                // Check there is data
                guard let geoData = data else { return }
                
                // Check if there is an error message in the data
                let dataAsString = String(decoding: geoData, as: UTF8.self)
                if dataAsString.range(of:"error_message") != nil { return }
                
                
                do {
                    // Docode and check value exists
                    let dataGeometryData = try JSONDecoder().decode(GeometryData.self, from: geoData)
                    guard let lat = dataGeometryData.results[0].geometry?.location?.lat else { return }
                    guard let lng = dataGeometryData.results[0].geometry?.location?.lng else { return }
                    
                    // doRequestForWeather
                    doRequestForWeather(address: address, lat: lat, lng: lng, nameOfLocation: nameOfLocation, completion: completion)
                    
                } catch let err { print("Error serializing json:", err) } // Try serialize data intp GeometryData failed
            } else { print("Status code not OK") } // HTTPResponse was not OK
        }else{ print(err!.localizedDescription) } // URLSession returned error
    }.resume()
}

func doRequestForWeather(address: String, lat: Float, lng: Float, nameOfLocation: String, completion: @escaping () -> Void){
    
    // Create url
    let latString = String(lat)
    let lngString =  String(lng)
    let key = "713c7f992495ef5a9223935db4428f4b"
    let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latString)&lon=\(lngString)&appid=\(key)"
    guard let url = URL(string: urlString) else { return }
    
    // Do GET request for weather data
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        if err == nil {
            
            // Check that the response code is OK
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if 200...299 ~= httpResponse.statusCode {
                
                // Check there is data
                guard let weatherData = data else { return }
                
                // Check if there is an error message in the data
                let dataAsString = String(decoding: weatherData, as: UTF8.self)
                if dataAsString.range(of:"error_message") != nil { return }
                
                do {
                    //Decode and check values exist
                    let dataWeatherData = try JSONDecoder().decode(LocalWeatherData.self, from: weatherData)
                    
                    // Add weather data to array
                    WeatherData.weatherData.weather.append(dataWeatherData)
                    
                    // Set location of data
                    WeatherData.weatherData.weather[WeatherData.weatherData.weather.count-1].location = nameOfLocation
                    
                    // Set index of data
                    WeatherData.weatherData.weather[WeatherData.weatherData.weather.count-1].index = WeatherData.weatherData.weather.count-1
                    
                    //dismiss this view cdontroller
                    completion()
                } catch let err { print("Error serializing json", err) }
            } else { print("Status code not OK") } // HTTPResponse was not OK
        } else { print(err!.localizedDescription) } // Request returned an error
    }.resume()
}

func doRequestForReverseGeoCoding(lon: Double, lat: Double, completion: @escaping () -> Void){
    print("start reverse geode request")
    //create url
    let key = "AIzaSyAHBr0CijiFUOXaiMkbOPHIsfhCp_tXkFA"
    let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lon),\(lat)&key=\(key)"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
           if err == nil {
               print("no error")
               // Check that the response code is OK
               guard let httpResponse = response as? HTTPURLResponse else {
                print("httpresponse error")
                return }
                print("http response ok")
               if 200...299 ~= httpResponse.statusCode {
                   print("status code ok")
                   // Check there is data
                   guard let weatherData = data else {
                    print("data is emty")
                    return
                    
                }
                   print("data is ok")
                   // Check if there is an error message in the data
                   let dataAsString = String(decoding: weatherData, as: UTF8.self)
                   if dataAsString.range(of:"error_message") != nil {
                    print("error message: " + dataAsString)
                    return }
                    print("data as string is:")
                   print(dataAsString)
                   completion()
                
                 //  do {
                       //Decode and check values exist
                       //let dataWeatherData = try JSONDecoder().decode(LocalWeatherData.self, from: weatherData)
                       
                       // Add weather data to array
                       //WeatherData.weatherData.weather.append(dataWeatherData)
                       
                       // Set location of data
                       //WeatherData.weatherData.weather[WeatherData.weatherData.weather.count-1].location = nameOfLocation
                       
                       // Set index of data
                       //WeatherData.weatherData.weather[WeatherData.weatherData.weather.count-1].index = WeatherData.weatherData.weather.count-1
                       
                       //dismiss this view cdontroller
                       //completion()
                    
                //   } catch let err { print("Error serializing json", err) }
               } else { print("Status code not OK") } // HTTPResponse was not OK
           } else { print(err!.localizedDescription) } // Request returned an error
       }.resume()

}
