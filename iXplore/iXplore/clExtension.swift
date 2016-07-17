
//
//  clExtension.swift
//  Pods
//
//  Created by Sam on 7/18/16.
//
//

import Foundation
import CoreLocation

extension CLLocation {
    
    
    class func compareCords(c1: CLLocationCoordinate2D, c2:CLLocationCoordinate2D) -> Bool {
        
        if c1.latitude == c2.latitude && c1.longitude == c2.longitude {
            return true
        }
        else {
            return false
        }
    }
    
}