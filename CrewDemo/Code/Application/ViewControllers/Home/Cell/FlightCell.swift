//
//  FlightCell.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {

    @IBOutlet weak var btnIcon: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTimeStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ item: FlightDetail) {
        lblTitle.text = "\(item.departure ?? "") - \(item.destination ?? "")"
        lblTime.text = "\(item.timeDepart ?? "") - \(item.timeArrive ?? "")"
        
        let status = Utility.getIconForDutyCode(item)
        self.btnIcon.setTitle(status.icon, for: .normal)
        lblSubtitle.text = status.subtitle
        if let value = status.strTime {
            lblTime.text = value
            lblTimeStatus.isHidden = false
            lblTimeStatus.text = STR_MATCH_CREW // No idea if this has to be static or dynamic, so assumes static
        } else {
            lblTimeStatus.isHidden = true
        }
    }

}
