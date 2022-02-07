//
//  WeatherMainViewModel.swift
//  ahoyweather
//
//  Created by faisal khalid on 06/02/2022.
//

import Foundation
import UIKit
import RxSwift
class WeatherDashboardViewModel {
    
    
   
    var tempH = Observable<String>.just("1")
    
    
    func fetchAllWeatherDataViewModels(byCity:String)->Observable<[WeatherDashboardListViewModel]>{
        
        
        let weather =  WeatherService.shared.weatherDataForLocation(city: byCity)
        
   
    return  WeatherService.shared.weatherDataForLocation(city: byCity).map {
            
            $0.forecast.map {
               
            WeatherDashboardListViewModel(weatherForecast: $0)
            }
        }

        
        

        
    }
    
}
