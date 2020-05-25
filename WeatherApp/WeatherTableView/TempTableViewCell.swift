//
//  TempTableViewCell.swift
//  WeatherApp
//
//  Created by calum boustead on 22/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class TempTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
