//
//  MyLocationTableViewCell.swift
//  WeatherApp
//
//  Created by calum boustead on 28/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class MyLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
