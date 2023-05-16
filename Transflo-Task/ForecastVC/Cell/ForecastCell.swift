//
//  ForecastCell.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 22/04/2023.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(forecastModel : List){
        weatherImg.downloadImage(path: NetworkingConstants.imgBaseUrl + "\(forecastModel.weather?.first?.icon ?? "").png")
        timeLbl.text = forecastModel.timeFormatted ?? ""
        minTempLbl.text = "\(forecastModel.main?.tempMin ?? 0)"
        maxTempLbl.text = "\(forecastModel.main?.tempMax ?? 0)"
        
    }
    
}
