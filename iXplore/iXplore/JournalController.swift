//
//  JournalController.swift
//  iXplore
//
//  Created by Sam on 7/10/16.
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




class JournalController {
    
    var journalList : [Journal] = []

        
    static let sharedInstance = JournalController()
    private init() {}
    
    func getJournals() -> [Journal] {
    
        let journal1 = Journal(title: "Lion's Head", coordinate: CLLocationCoordinate2D(latitude: -33.9350, longitude: 18.2890), notes: "Nice Hike. Good View", date: "7.3.16")
        
        let journal2 = Journal(title: "Table Mountain", coordinate: CLLocationCoordinate2D(latitude: -33.9628, longitude: 18.4098), notes: "View was okay.", date: "7.3.16")
        
        let journal3 = Journal(title: "Two Oceans Aquarium", coordinate: CLLocationCoordinate2D(latitude: -33.5428, longitude: 18.250356), notes: "Better than expected.", date: "7.2.16")

        let journal4 = Journal(title: "Spice Route", coordinate: CLLocationCoordinate2D(latitude: -33.450, longitude: 18.5510), notes: "The beer was good.", date: "7.9.16")
        
        let journal5 = Journal(title: "Never@home", coordinate: CLLocationCoordinate2D(latitude: -33.907772, longitude : 18.40918), notes: "Needs better wifi connection.", date: "6.26.16")
        
        journalList.append(journal1)
        journalList.append(journal2)
        journalList.append(journal3)
        journalList.append(journal4)
        journalList.append(journal5)
        
        return journalList
    
    }
    
    
        
        
        
        
}

