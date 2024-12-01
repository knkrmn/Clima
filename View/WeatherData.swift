//
//  WeatherData.swift
//  Clima
//
//  Created by Okan Karaman on 29.11.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable  {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Decodable {
    let temp : Double
}

struct Weather: Decodable {
    let description : String
    let id : Int
}
