//
//  Location.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 28/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    
    @objc public dynamic var latitude = 0.0
    @objc public dynamic var longitude = 0.0
    
    
    convenience init (latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}

