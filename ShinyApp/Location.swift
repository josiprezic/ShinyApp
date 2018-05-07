//
//  Location.swift
//  ShinyApp
//
//  Created by Josip Rezic on 03/05/2018.
//  Copyright © 2018 QSD. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
