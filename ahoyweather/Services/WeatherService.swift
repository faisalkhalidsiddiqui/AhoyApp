//
//  WeatherService.swift
//  ahoyweather
//
//  Created by FAISAL KHALID on 05/02/2022.
//

import Foundation
import RxSwift
import UIKit


class WeatherService {
    
    public static let shared =  WeatherService()
    private let apiKey = "02cdd1062152448dbe9ec77266290732"
    private let host = "api.weatherbit.io"
    private let path = "/v2.0/forecast/daily"
    private let fahrenheit = "I"
    
    private var measurement:String {
        if SettingsManager.shared.tempMeasurement == .fahrenheit {
            return "I"
        }
        return "M"
    }
    
     func weatherDataForLocation(city:String)->Observable<Weather> {
        
         return Observable.create { observer in
             
             var urlBuilder = URLComponents()
             urlBuilder.scheme = "https"
             urlBuilder.host = self.host
             urlBuilder.path = self.path
             urlBuilder.queryItems = [
                URLQueryItem(name: "key", value: self.apiKey),
                URLQueryItem(name: "units", value: self.measurement),
               URLQueryItem(name: "city", value: "\(city)")

             ]
             
             let url = urlBuilder.url!
              
             print(url.absoluteURL)
            let task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
               //execute completion handler on main thread
               DispatchQueue.main.async {
                 guard error == nil else {
                   print("Failed request from Weatherbit: \(error!.localizedDescription)")
                     observer.onError(WeatherServiceError.failedRequest)
                   return
                 }
                 
                 guard let data = data else {
                   print("No data returned from Weatherbit")
                     observer.onError(WeatherServiceError.noData)

                   return
                 }
                 
                 guard let response = response as? HTTPURLResponse else {
                   print("Unable to process Weatherbit response")
                     observer.onError(WeatherServiceError.invalidResponse)
                   return
                 }
                 
                 guard response.statusCode == 200 else {
                   print("Failure response from Weatherbit: \(response.statusCode)")
                     observer.onError(WeatherServiceError.failedRequest)
                   return
                 }
                 
                 do {
                   let decoder = JSONDecoder()
                   let weatherData: Weather = try decoder.decode(Weather.self, from: data)
                     observer.onNext(weatherData)
                 } catch {
                     print(String(describing: error)) // <- ✅ Use this for debuging!

                   print("Unable to decode Weatherbit response: \(error.localizedDescription)")
                     observer.onError(WeatherServiceError.invalidData)
                 }
               }
             }
             task.resume()
             
             return Disposables.create {
                           task.cancel()
                       }
         }
     
      }
    

    
    
}


enum WeatherServiceError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}


