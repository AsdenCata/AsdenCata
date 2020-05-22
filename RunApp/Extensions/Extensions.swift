//
//  Extensions.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 22/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import Foundation


extension Double {
    
    func metersToKm(decimals: Int) -> Double {
        let divisor = pow(10.0, Double(decimals)) //setting the double to show only x(decimals) amount of decimals
        return ((self / 1000) * divisor).rounded() / divisor  //converting meeters to km
    }
    
}

