//
//  Utility.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation

typealias dutyStatus = (icon:String,subtitle:String,strTime: String?)
class Utility {
    
    //MARK: - changeFormateOfStringDate
    class func changeFormateOfStringDate(_ strDate:String, strRequireFormate:String, strCurrentFormate:String) -> String {
        let date:Date = Utility.convertStringToDate(strDate, format: strCurrentFormate)
        let str = self.convertDateToString(date, format: strRequireFormate)
        return str
    }
    
    class func convertDateToString( _ date: Date, format: String) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        
        return dateformatter.string(from: date)
    }
    //MARK: convert String to Date with Format
    class func convertStringToDate(_ strDate: String, format: String) -> Date{
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.date(from: strDate)!
        
    }
    //MARK: Get FontAwesome icon
    class func getIconFromString(_ iconString: UniChar) -> String {
        return (String(format: "%C", iconString))
    }
    
    class func getIconForDutyCode(_ item : FlightDetail) -> dutyStatus {
        guard let dutyCode = item.dutyCode else {
            return ("","", nil)
        }
        switch dutyCode {
        case DutyCode.flight.rawValue:
            return (getIconFromString(FontAwesome.plane.rawValue),"", nil)
        case DutyCode.layover.rawValue:
            return (getIconFromString(FontAwesome.layover.rawValue), item.departure ?? "", nil)
        case DutyCode.off.rawValue:
            return (getIconFromString(FontAwesome.off.rawValue), item.dutyCode ?? "", nil)
        case DutyCode.standBy.rawValue:
            let standbyTime = changeFormateOfStringDate(item.timeArrive!, strRequireFormate: DateFormats.hour24HHMM.rawValue, strCurrentFormate: DateFormats.hour24HHMMSS.rawValue)
            return (getIconFromString(FontAwesome.standBy.rawValue), "\(item.dutyId ?? "") (\(item.departure ?? ""))", "\(standbyTime) Hours")
        default:
            
            return (getIconFromString(FontAwesome.noData.rawValue),"", nil)
        }
    }
}
