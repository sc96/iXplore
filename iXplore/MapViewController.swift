//
//  MapViewController.swift
//  iXplore
//
//  Created by Sam on 7/10/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var journalList : [Journal] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        
        //JournalController.sharedInstance.getJournals()
        
        navigationItem.title = "IXplore"
        
        
        
        let add_button : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(addAction(_:)))
        
        
        navigationItem.rightBarButtonItem = add_button
        
        print(journalList.count)
        journalList = JournalController.sharedInstance.getJournals()
        
        for journal in journalList {
            
            mapView.addAnnotation(journal)
            
        }

        
        /*
        for journal in journalList {
            mapView.addAnnotation(journal) */
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        for journal in journalList {
            
            mapView.addAnnotation(journal)
            
        }
        
        
        tableView.reloadData()
    }
    
        


    func addAction(sender:UIBarButtonItem){
        
        let NewEntryViewController = newEntryViewController(nibName: "newEntryViewController", bundle: nil)
        
        self.presentViewController(NewEntryViewController, animated : true, completion: nil)
        
        
    
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return JournalController.sharedInstance.journalList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("reusable")
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reusable")
        }
        
        
        
        
        cell!.textLabel?.text = "\(JournalController.sharedInstance.journalList[indexPath.row].title!)"
        return cell!
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
        let location = JournalController.sharedInstance.journalList[indexPath.row].coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    
    
    
    
    
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if (annotationView == nil) {
            
            
            
            let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            leftLabel.textColor = UIColor.blackColor()
            
            
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView!.leftCalloutAccessoryView = leftLabel
            annotationView!.canShowCallout = true
            
            //    annotationView?.pinTintColor = UIColor.purpleColor()
            
       //     annotationView!.image = UIImage(named: "google.png")
            
            
            var frame = annotationView!.frame
            frame.size.height = 25
            frame.size.width = 25
            annotationView!.frame = frame
            
        }
        
        let label = annotationView!.leftCalloutAccessoryView as! UILabel
        label.text = annotation.title!
        
        
        annotationView!.annotation = annotation
        return annotationView!
        
    }
    
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
