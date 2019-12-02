//
//  ScheduleView.swift
//  CrewDemo
//
//  Created by Wasim on 15/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

class ScheduleView: WMView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblDepartureCity: UILabel!
    @IBOutlet weak var lblDesinationCity: UILabel!
    @IBOutlet weak var lblDepartureTime: UILabel!
    @IBOutlet weak var lblDepartureDay: UILabel!
    @IBOutlet weak var lblArrivalTime: UILabel!
    @IBOutlet weak var lblArrivalDay: UILabel!
    @IBOutlet weak var btnPlane: UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ScheduleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupData(_ flightData: FlightDetail) {
        lblDepartureCity.text = flightData.departure
        lblDesinationCity.text = flightData.destination
        lblDepartureTime.text = flightData.timeDepart
        lblDepartureDay.text = flightData.date
        lblArrivalTime.text = flightData.timeArrive
        lblArrivalDay.text = flightData.date
        
        let status = Utility.getIconFromString(FontAwesome.plane.rawValue)
        self.btnPlane.setTitle(status, for: .normal)
    }
}
