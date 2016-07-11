//
//  JournalController.swift
//  iXplore
//
//  Created by Sam on 7/10/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import Foundation
import MapKit







class JournalController {
    
    var journalList : [Journal] = []
    var manager = NSFileManager.defaultManager()

        
    static let sharedInstance = JournalController()
    private init() {}
    
    
    // this function is pretty useless now
    func getJournals() -> [Journal] {
    /*
        
        let journal1 = Journal(title: "Lion's Head", coordinate: CLLocationCoordinate2D(latitude: -33.9350, longitude: 18.3890), notes: "Nice Hike. Good View", date: "7.3.16")
        
        let journal2 = Journal(title: "Table Mountain", coordinate: CLLocationCoordinate2D(latitude: -33.9628, longitude: 18.4098), notes: "View was okay.", date: "7.3.16")
        
        let journal3 = Journal(title: "Two Oceans Aquarium", coordinate: CLLocationCoordinate2D(latitude: -33.9080, longitude: 18.4177), notes: "Better than expected.", date: "7.2.16")

        let journal4 = Journal(title: "Spice Route", coordinate: CLLocationCoordinate2D(latitude: -33.4550, longitude: 18.5510), notes: "The beer was good.", date: "7.9.16")
        
        let journal5 = Journal(title: "Never@home", coordinate: CLLocationCoordinate2D(latitude: -33.907638, longitude : 18.406225), notes: "Needs better wifi connection.", date: "6.26.16")
        
        journalList.append(journal1)
        journalList.append(journal2)
        journalList.append(journal3)
        journalList.append(journal4)
        journalList.append(journal5) */
        
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileUrl = documents.URLByAppendingPathComponent("journal.txt")
        
        if let jList = NSKeyedUnarchiver.unarchiveObjectWithFile(fileUrl.path!) as? [Journal] {
            
            journalList = jList
            
        }
        
        return journalList
    
    }
    
    
        
        
        
        
}

