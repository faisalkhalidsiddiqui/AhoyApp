//
//  WeatherMainViewModel.swift
//  ahoyweather
//
//  Created by faisal khalid on 06/02/2022.
//

import Foundation
import UIKit
import RxSwift
class WeatherDashboardListViewModel {
    
    let weatherForecast:WeatherForecast!
    
    var thumbnail: UIImage {
        return UIImage(named: "WeatherIcons/\(weatherForecast.weather.icon)")!
    }
    
    
    var shortDescription: String {
        
        return weatherForecast.weather.weatherDescription
    }
    var tempH: String {
        
        return  (SettingsManager.shared.tempMeasurement == .fahrenheit) ? "\(weatherForecast.maxTemp)° F" : "\(weatherForecast.maxTemp)° C"
    
    }
    
    
    var tempL: String {
        return  (SettingsManager.shared.tempMeasurement == .fahrenheit) ? "\(weatherForecast.minTemp)° F" : "\(weatherForecast.minTemp)° C"
    }
    
    var  day: String {
        
        return weatherForecast.datetime
    }
   
    
    init(weatherForecast:WeatherForecast){
        self.weatherForecast = weatherForecast
    }
    
    
    
}
