//
//  MoreViewController.swift
//  iXplore
//
//  Created by Sam on 7/13/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    // stupid but it works
    var titleDummy : String?
    var dateDummy: String?
    var notesDummy: String?
    var imageDummy: UIImage?
    
 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = titleDummy
        dateLabel.text = dateDummy
        notesLabel.text = notesDummy
        imageView.image = imageDummy
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
