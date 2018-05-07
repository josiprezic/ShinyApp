//
//  WeatherVC.swift
//  ShinyApp
//
//  Created by Josip Rezic on 02/05/2018.
//  Copyright © 2018 QSD. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        forecast = Forecast()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
        currentWeather.downloadWeatherDeteils {
            self.downloadForecastData {
                //print("updating UI...")
                self.updateMainUI()
                //print("UI updated!")
            }
        }
    }
    
   func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            guard let coordinate = locationManager.location?.coordinate else { return }
            Location.sharedInstance.latitude = coordinate.latitude
            Location.sharedInstance.longitude = coordinate.longitude
            print("hello from location")
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
            print("hello without location")
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    var objIndex = 0
                    for obj in list {
                        if let dateTxt = list[objIndex]["dt_txt"] as? String {
                                let f = Forecast(weatherDict: obj)
                            if dateTxt.range(of:" 12:00:00") != nil {
                                self.forecasts.append(f)
                            }
                        }
                        objIndex += 1
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateMainUI() {
        print("hello from updateMainUI")
        //print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        print("forecast_url:" + FORECAST_URL)
        print("currentWeather_url:" + CURRENT_WEATHER_URL)
        
        dateLabel.text = currentWeather.date
        let temp = (round(currentWeather.currentTemp*10)/10)
        //let temp = (String(currentWeather.currentTemp))
        
        currentTempLabel.text = "\(temp)°"
        cityLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        currentWeatherLabel.text = currentWeather.weatherType
    }
}
