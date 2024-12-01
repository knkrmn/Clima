//
//  WeatherManager.swift
//  Clima
//
//  Created by Okan Karaman on 28.11.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate: AnyObject {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel)
    func didFailWithError(_ weatherManager : WeatherManager,error: Error)

}

struct WeatherManager {
    
    weak var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=e0e38285288f7f19013d65a67d7ad82e"
    
    func fetchWeather(cityName : String) -> Void {
        let url : String = "\(weatherURL)&q=\(cityName)"
        self.perfomRequest(urlString: url)
    }
    
    func fetchWeather(longitude : CLLocationDegrees, latitude : CLLocationDegrees) {
        let url : String = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        print(url)
        self.perfomRequest(urlString: url)
    }
    
    func perfomRequest(urlString: String) {
        // 1 Create URL
        if let url = URL(string: urlString) {
            
            //2 Create Session
            
            let session = URLSession(configuration: .default)
            
            //3 Give the session a task
            
            let task = session.dataTask(with: url) { (data , response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(self,error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
                
            }
            // 4 Start the task
            task.resume()
        }
    }
    
    func parseJSON (weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(self,error: error)
            return nil
        }
    }
}
