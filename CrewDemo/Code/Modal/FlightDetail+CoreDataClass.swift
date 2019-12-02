//
//  FlightDetail+CoreDataClass.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FlightDetail)
public class FlightDetail: NSManagedObject {

    func setFromDict(_ dicdata :NSDictionary) {
        
        if let keyval = dicdata["Flightnr"] as? String {
            self.flightNr = keyval
        }
        if let keyval = dicdata["Date"] as? String {
            self.date = keyval
        }
        if let keyval = dicdata["Aircraft Type"] as? String {
            self.aircraftType = keyval == "" ? "N/A" : keyval
        }
        if let keyval = dicdata["Tail"] as? String {
            self.tail = keyval == "" ? "N/A" : keyval
        }
        if let keyval = dicdata["Departure"] as? String {
            self.departure = keyval
        }
        if let keyval = dicdata["Destination"] as? String {
            self.destination = keyval
        }
        if let keyval = dicdata["Time_Depart"] as? String {
            self.timeDepart = keyval
        }
        if let keyval = dicdata["Time_Arrive"] as? String {
            self.timeArrive = keyval
        }
        if let keyval = dicdata["DutyID"] as? String {
            self.dutyId = keyval
        }
        if let keyval = dicdata["DutyCode"] as? String {
            self.dutyCode = keyval == "" ? "N/A" : keyval
        }
        if let keyval = dicdata["Captain"] as? String {
            self.captain = keyval == "" ? "Not Available" : keyval
        } else {
            self.captain = "Not Available"
        }
        if let keyval = dicdata["First Officer"] as? String {
            self.firstOfficer = keyval == "" ? "Not Available" : keyval
        } else {
            self.firstOfficer = "Not Available"
        }
        if let keyval = dicdata["Flight Attendant"] as? String {
            self.flightAttendant = keyval == "" ? "Not Available" : keyval
        } else {
            self.flightAttendant = "Not Available"
        }
    }
}
