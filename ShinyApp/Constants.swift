//
//  Constants.swift
//  ShinyApp
//
//  Created by Josip Rezic on 02/05/2018.
//  Copyright © 2018 QSD. All rights reserved.
//

import Foundation

let mostarLatitude = "43.343033"
let mostarLongitude = "17.807894"

let BASE_URL = "https://api.openweathermap.org/data/2.5/"

let CURRENT_WEATHER_EXTENSION = "weather?"
let FORECAST_EXTENSION = "forecast?"

let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "1fde9a13d87e0113c3c74d9ad752b7c9"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = BASE_URL + CURRENT_WEATHER_EXTENSION + LATITUDE + "\(Location.sharedInstance.latitude!)" + LONGITUDE + "\(Location.sharedInstance.longitude!)" + APP_ID + API_KEY
let FORECAST_URL = BASE_URL + FORECAST_EXTENSION + LATITUDE + "\(Location.sharedInstance.latitude!)" + LONGITUDE + "\(Location.sharedInstance.longitude!)" + APP_ID + API_KEY

//harcoded for Mostar
//let CURRENT_WEATHER_URL = BASE_URL + CURRENT_WEATHER_EXTENSION + LATITUDE + mostarLatitude + LONGITUDE + mostarLongitude + APP_ID + API_KEY
//let FORECAST_URL = BASE_URL + FORECAST_EXTENSION + LATITUDE + mostarLatitude + LONGITUDE + mostarLongitude + APP_ID + API_KEY


