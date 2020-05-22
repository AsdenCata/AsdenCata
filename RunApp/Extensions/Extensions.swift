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

extension Int {
    
    func formatTimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60 //how many times doeas self fit in 3600
        let durationSeconds = (self % 3600) % 60
        
        if durationSeconds < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durationSeconds) //durationMinues is the firs %02d and durationSeconds is the second %02d; , %02d = we always want 2 elemnts / chracters, if we hav eonly one it will put 0 in front ex 01; d is from decimals
            }
        }
        return String(format: "%02d:%02d%02d", durationHours, durationMinutes, durationSeconds)
    }
}
