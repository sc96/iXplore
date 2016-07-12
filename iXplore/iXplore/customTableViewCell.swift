//
//  customTableViewCell.swift
//  iXplore
//
//  Created by Sam on 7/12/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
