//
//  HomePresenter.swift
//  CrewDemo
//
//  Created by Wasim on 15/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation

@objc protocol HomeDelegate: class {
    @objc optional func displayProgress()
    @objc optional func removeProgress()
    func didFinishLoadingData(_ data: [FlightDetail])
    func dataDidFailLoading(_ error:NSError?)
}

class HomePresenter {
    weak var delegate: HomeDelegate?
    init(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func chekForData() {
        let flightData = FlightDBManager.sharedInstance.getFlightData()
        if flightData.count > 0 {
            delegate?.didFinishLoadingData(flightData)
        } else {
            getData()
        }
    }
    
    func getData() {
        delegate?.displayProgress?()
        APIController.getWithUrl(APiUrl.dummyData.rawValue, paramDict: NSDictionary() , onSuccess: { (response:AnyObject?) in
            self.delegate?.removeProgress?()
            self.processResponse(response as! NSArray)
            
        }) { (error:NSError?) in
            self.delegate?.removeProgress?()
            self.delegate?.dataDidFailLoading(error)
        }
    }
    
    func processResponse(_ dataDict: NSArray) {
        FlightDBManager.sharedInstance.saveFlightData(dataDict)
        let flightData = FlightDBManager.sharedInstance.getFlightData()
        delegate?.didFinishLoadingData(flightData)
    }
}
