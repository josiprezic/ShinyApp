//
//  WeatherCell.swift
//  ShinyApp
//
//  Created by Josip Rezic on 03/05/2018.
//  Copyright © 2018 QSD. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherMaxTempLabel: UILabel!
    @IBOutlet weak var weatherMinTempLabel: UILabel!

    func configureCell(forecast: Forecast) {
        weatherMinTempLabel.text = "\(forecast.lowTemp)°"
        weatherMaxTempLabel.text = "\(forecast.highTemp)°"
        weatherTypeLabel.text = forecast.weatherType
        weatherDayLabel.text = forecast.date
        weatherImage.image = UIImage(named: forecast.weatherType)
        
        //hidden because it is equal to max temp (because it's mesuared at the same time)
        //TODO: find max and min temp of the day
        weatherMinTempLabel.isHidden = true
        
    }
}
