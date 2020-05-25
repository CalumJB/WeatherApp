//
//  OtherInfoTableViewCell.swift
//  WeatherApp
//
//  Created by calum boustead on 22/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class OtherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var leftOtherAttributeTypeLabel: UILabel!
    @IBOutlet weak var leftOtherAttributeValueLabel: UILabel!
    @IBOutlet weak var rightOtherAttributeTypeLabel: UILabel!
    @IBOutlet weak var rightOtherAttributeValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
