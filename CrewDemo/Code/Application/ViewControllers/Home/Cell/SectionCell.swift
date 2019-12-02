//
//  SectionCell.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

class SectionCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ title: String) {
        lblTitle.text = Utility.changeFormateOfStringDate(title, strRequireFormate: DateFormats.dateWithDayName.rawValue, strCurrentFormate: DateFormats.ddMMYYYY.rawValue)
    }

}
