//
//  CityCell.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(cityName : String){
        cityNameLbl.text = cityName
    }
    
}
