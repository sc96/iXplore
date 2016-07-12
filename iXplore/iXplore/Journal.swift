//
//  Journal.swift
//  iXplore
//
//  Created by Sam on 7/11/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import Foundation
import MapKit



class Journal : NSObject, MKAnnotation, NSCoding {
    
    
    var title : String?
    var coordinate : CLLocationCoordinate2D
    var notes : String?
    var date : String?
    var longitude : Double?
    var latitude:  Double?
    var picture: UIImage?
    
    init(title : String, latitude: Double, longitude : Double, notes : String, date: String) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.notes = notes
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(title : String, coordinate: CLLocationCoordinate2D, notes : String, date: String) {
        self.title = title
        self.coordinate = coordinate
        self.notes = notes
        self.date = date
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    
    
    required init?(coder: NSCoder) {
        title = (coder.decodeObjectForKey("title") as? String) ?? ""
        date = (coder.decodeObjectForKey("date") as? String) ?? ""
        notes = (coder.decodeObjectForKey("notes") as? String) ?? ""
        latitude = (coder.decodeObjectForKey("latitude") as? Double) ?? -34
        longitude = (coder.decodeObjectForKey("longitude") as? Double) ?? 18.5
        coordinate = (coder.decodeObjectForKey("coordinate") as? CLLocationCoordinate2D) ?? CLLocationCoordinate2D(latitude: -34.0, longitude: 18.45)
        picture = (coder.decodeObjectForKey("picture") as? UIImage ?? UIImage())
        
        
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(title, forKey: "title")
        coder.encodeObject(date, forKey: "date")
        coder.encodeObject(notes, forKey: "notes")
        coder.encodeObject(latitude, forKey: "latitude")
        coder.encodeObject(longitude, forKey: "longitude")
        coder.encodeObject(coordinate as? AnyObject, forKey: "coordinate")
        coder.encodeObject(picture as? AnyObject, forKey: "picture")
}

}