//
//  Journal.swift
//  iXplore
//
//  Created by Sam on 7/11/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import Foundation
import MapKit



class Journal : NSObject, MKAnnotation {
    
    
    var title : String?
    var coordinate : CLLocationCoordinate2D
    var notes : String?
    var date : String?
    
    init(title : String, coordinate: CLLocationCoordinate2D, notes : String, date: String) {
        self.title = title
        self.coordinate = coordinate
        self.notes = notes
        self.date = date
    }
    
    
    
    
}