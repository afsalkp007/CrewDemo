//
//  HomeDetailViewController.swift
//  CrewDemo
//
//  Created by Wasim on 15/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

class HomeDetailViewController: BaseViewController {

    @IBOutlet weak var viewSchedule: ScheduleView!
    @IBOutlet weak var viewCaptain: NameView!
    @IBOutlet weak var viewOfficer: NameView!
    @IBOutlet weak var viewAttandance: NameView!
    @IBOutlet weak var viewAirCraft: NameView!
    @IBOutlet weak var viewDuty: NameView!
    @IBOutlet weak var viewTail: NameView!
    var detailData: FlightDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    fileprivate func setupView() {
        guard let flightDetail = detailData else {
            return
        }
        if let value = flightDetail.date {
          self.title =  Utility.changeFormateOfStringDate(value, strRequireFormate: DateFormats.dateWithDayName.rawValue, strCurrentFormate: DateFormats.ddMMYYYY.rawValue)
        }
        viewSchedule.setupData(flightDetail)
        
        viewCaptain.setupView(with: flightDetail.captain, subTitle: STR_CAPTAIN)
        viewOfficer.setupView(with: flightDetail.firstOfficer, subTitle: STR_FIRST_OFFICER)
        viewAttandance.setupView(with: flightDetail.flightAttendant, subTitle: STR_FLIGHT_ATTANDANCE)
        var strAircraftType = flightDetail.aircraftType
        if let value = flightDetail.flightNr {
            strAircraftType =  "\(value) - \(strAircraftType ?? "")"
        }
        viewAirCraft.setupView(with: strAircraftType, subTitle: STR_AIRCRAFT_TYPE)
        viewDuty.setupView(with: flightDetail.dutyCode, subTitle: STR_DUTY_CODE)
        viewTail.setupView(with: flightDetail.tail, subTitle: STR_TAIL)
    }

}
