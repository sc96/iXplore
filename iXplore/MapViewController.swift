//
//  MapViewController.swift
//  iXplore
//
//  Created by Sam on 7/10/16.
//  Copyright © 2016 Sam. All rights reserved.
// TODO: Blue dot is missing. Test the Persistance

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var locationManager : CLLocationManager = CLLocationManager()
    var manager = NSFileManager.defaultManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.registerNib(UINib(nibName: "customTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 80
        
        // this is to remove the empty space on the top of the table view. ns if it breaks anything lol
        self.automaticallyAdjustsScrollViewInsets = false


        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        navigationItem.title = "IXplore"
        let add_button : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(addAction(_:)))
        navigationItem.rightBarButtonItem = add_button
        
        
        
        /*
        
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileUrl = documents.URLByAppendingPathComponent("journals.txt")
        
        if let jList = NSKeyedUnarchiver.unarchiveObjectWithFile(fileUrl.path!) as? [Journal] {
            
            JournalController.sharedInstance.journalList = jList
            
        } */
        locationManager.requestWhenInUseAuthorization()
        
        
        
        mapView.addAnnotations(JournalController.sharedInstance.getJournals())
        print(JournalController.sharedInstance.journalList.count)

        

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        
        for journal in JournalController.sharedInstance.journalList {
            
            mapView.addAnnotation(journal)
            
        }
        
        
        tableView.reloadData()
        
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
        
       /*
        var cell = tableView.dequeueReusableCellWithIdentifier("reusable")
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reusable")
        } */
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath)
            as! customTableViewCell
        
        
        
        
        
        
        
        
     /*   cell.titleLabel.text = "\(JournalController.sharedInstance.journalList[indexPath.row].title!)" */
        cell.dateLabel.text = "date"
        
        if let image =  JournalController.sharedInstance.journalList[indexPath.row].picture {
        cell.imageView!.image = image
        }
        
        if let title = JournalController.sharedInstance.journalList[indexPath.row].title {
            cell.titleLabel.text = title
        }
        
        if let date = JournalController.sharedInstance.journalList[indexPath.row].date {
            cell.dateLabel.text = date
        }
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
        let location = JournalController.sharedInstance.journalList[indexPath.row].coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    
    
    
    
    
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .Normal , title: "Delete") { action, index in
    
            
            let journal = JournalController.sharedInstance.journalList.removeAtIndex(indexPath.row)
            
            
            let documents = self.manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let fileUrl = documents.URLByAppendingPathComponent("please.txt")
            
            NSKeyedArchiver.archiveRootObject(JournalController.sharedInstance.journalList, toFile: fileUrl.path!)
            
            
            tableView.reloadData()
            
            
            //
            for annotation in self.mapView.annotations {
                if annotation.title! == journal.title {
                    if  CLLocation.compareCords(annotation.coordinate, c2: journal.coordinate) {
                        self.mapView.removeAnnotation(annotation)
                    }
                    
                }
            }
        
        
            
            
        }
        delete.backgroundColor = UIColor.redColor()
        
        let edit = UITableViewRowAction(style: .Normal, title: "edit") { action, index in
            print("edit button tapped")
        }
        edit.backgroundColor = UIColor.orangeColor()
        
        let view = UITableViewRowAction(style: .Normal, title: "view") { action, index in
            
            let moreViewController = MoreViewController(nibName: "MoreViewController", bundle: nil)
            moreViewController.titleDummy = JournalController.sharedInstance.journalList[index.row].title
            moreViewController.dateDummy = JournalController.sharedInstance.journalList[index.row].date
            moreViewController.notesDummy = JournalController.sharedInstance.journalList[index.row].notes
            moreViewController.imageDummy = JournalController.sharedInstance.journalList[index.row].picture
            
                                                        
            self.presentViewController(moreViewController, animated : true, completion: nil) 
            
        }
        view.backgroundColor = UIColor.lightGrayColor()
        
        return [delete, edit, view]
    }
    
    
    

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation.isKindOfClass(MKUserLocation)) {
            return nil
        }
        
        let identifier = "MyPin"
        
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("MyPin") as? MKPinAnnotationView
        
    
        
        if (annotationView == nil) {
            
            
            let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            leftLabel.textColor = UIColor.blackColor()
            
            
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            
            
            
            annotationView!.leftCalloutAccessoryView = leftLabel
            annotationView!.canShowCallout = true
            
         
            
            var frame = annotationView!.frame
            frame.size.height = 25
            frame.size.width = 25
            annotationView!.frame = frame
            
            
           
            
        }
        
    
        
        annotationView!.annotation = annotation
        return annotationView!
        
    }
    
    
    
    
    /* SELECTOR FUNCTIONS */
    
    func addAction(sender:UIBarButtonItem){
        
        let NewEntryViewController = newEntryViewController(nibName: "newEntryViewController", bundle: nil)
        
        self.presentViewController(NewEntryViewController, animated : true, completion: nil)
        
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
