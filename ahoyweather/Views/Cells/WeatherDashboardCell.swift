//
//  WeatherCell.swift
//  ahoyweather
//
//  Created by faisal khalid on 06/02/2022.
//

import UIKit

class WeatherDashboardCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var tempH: UILabel!
    @IBOutlet weak var tempL: UILabel!
    @IBOutlet weak var day: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
