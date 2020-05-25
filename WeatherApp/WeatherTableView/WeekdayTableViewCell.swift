//
//  WeekdayTableViewCell.swift
//  WeatherApp
//
//  Created by calum boustead on 26/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class WeekdayTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
