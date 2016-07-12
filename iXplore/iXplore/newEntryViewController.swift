//
//  newEntryViewController.swift
//  iXplore
//
//  Created by Sam on 7/11/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class newEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var latitudeField: UITextField!

    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var notesField: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    var manager = NSFileManager.defaultManager()
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
            
            if (locationManager.location != nil) {
                latitudeField.text = String(locationManager.location!.coordinate.latitude)
                longitudeField.text = String(locationManager.location!.coordinate.longitude)
            }
            
            
            
        }
        
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("imagePressed"))
        imageView.addGestureRecognizer(tap)
        imageView.userInteractionEnabled = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePressed() -> Void {
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    

    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let convertedDate = dateFormatter.stringFromDate(NSDate())
        
        
        let coordinate = CLLocationCoordinate2D(latitude: Double(latitudeField.text!)!, longitude: Double(longitudeField.text!)!)
        let journal = Journal(title: titleField.text!, coordinate: coordinate, notes: notesField.text!, date: "6.6.16")
        
        if (imageView.image != nil) {
            
            journal.picture = imageView.image
        }
        
        journal.date = convertedDate
        
        
        
        
        JournalController.sharedInstance.journalList.append(journal)
        
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileUrl = documents.URLByAppendingPathComponent("please.txt")
        
 
        
        NSKeyedArchiver.archiveRootObject(JournalController.sharedInstance.journalList, toFile: fileUrl.path!)

            
        self.dismissViewControllerAnimated(true, completion: nil)
            
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        titleField.becomeFirstResponder()
    }
    
    
    
    
    
    @IBAction func titleFieldEnterPressed(sender: UITextField) {
        notesField.becomeFirstResponder()
    }
    
    
    
    @IBAction func notesFieldEnterPressed(sender: UITextField) {
        latitudeField.becomeFirstResponder()
    }
    
    
    @IBAction func latitudeFieldEnterPressed(sender: AnyObject) {
        longitudeField.becomeFirstResponder()
    }
    
    
    @IBAction func longitudeFieldEnterPressed(sender: UITextField) {
        longitudeField.resignFirstResponder()
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
