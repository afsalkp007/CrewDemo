//
//  FlightDetail+CoreDataProperties.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//
//

import Foundation
import CoreData


extension FlightDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlightDetail> {
        return NSFetchRequest<FlightDetail>(entityName: "FlightDetail")
    }

    @NSManaged public var flightNr: String?
    @NSManaged public var date: String?
    @NSManaged public var aircraftType: String?
    @NSManaged public var tail: String?
    @NSManaged public var departure: String?
    @NSManaged public var destination: String?
    @NSManaged public var timeDepart: String?
    @NSManaged public var timeArrive: String?
    @NSManaged public var dutyId: String?
    @NSManaged public var dutyCode: String?
    @NSManaged public var captain: String?
    @NSManaged public var firstOfficer: String?
    @NSManaged public var flightAttendant: String?

}
