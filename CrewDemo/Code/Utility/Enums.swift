//
//  Enums.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation

enum DateFormats: String {
    case ddMMYYYY        = "dd/MM/yyyy"
    case dateWithDayName = "EE dd MMM, yyyy"
    case hour24HHMM      = "HH:mm"
    case hour24HHMMSS    = "HH:mm:ss"
}


enum DutyCode: String {
    case flight  = "FLIGHT"
    case off     = "OFF"
    case standBy = "Standby"
    case layover = "LAYOVER"
}

enum FontAwesome : UniChar {
    case plane          = 0xf072
    case layover        = 0xf0f2
    case standBy        = 0xf249
    case off            = 0xf236
    case planeDeparture = 0xf5af
    case noData         = 0xf273
}

enum APiUrl: String {
    case dummyData = "/uploads/dummy-response.json"
}
