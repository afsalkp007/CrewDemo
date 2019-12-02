//
//  FlightDBManager.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation
import CoreData
class FlightDBManager: DBManager {
    var subContext:NSManagedObjectContext!
    static let sharedInstance: FlightDBManager = FlightDBManager.init()
    
    //MARK: - Init
    override init(){
        super.init()
        subContext = DBManager.shared.managedObjectContext
    }
    
    //MARK: - initWithChildContext
    static func initWithChildContext() -> FlightDBManager {
        let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childContext.parent = DBManager.shared.managedObjectContext
        return FlightDBManager.init(context: childContext)
    }
    
    //MARK: - managedObjectContextDidSave
    @objc func managedObjectContextDidSave(notification: NSNotification) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        
        DispatchQueue.main.async { () -> Void in
            self.subContext.mergeChanges(fromContextDidSave: notification as Notification)
            DBManager.shared.saveContext()
        }
    }
    
    //MARK: - initWithContext
    init(context:NSManagedObjectContext) {
        super.init()
        subContext = context
    }
    
    //MARK:- saveContext
    override func saveChildContext() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextDidSave(notification:)),
                                       name: NSNotification.Name.NSManagedObjectContextDidSave,
                                       object: subContext)
        self.saveContext()
        
    }
    
    //MARK: - saveContext
    override func saveContext() {
        if subContext.hasChanges {
            do {
                try subContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func flightDetailTypeFetchRequest() -> NSFetchRequest<NSFetchRequestResult>{
        return NSFetchRequest<NSFetchRequestResult>(entityName: "FlightDetail")
    }
    
    // MARK: - save Flight data
    func saveFlightData(_ arrFlight:NSArray) {
        removeAllFlightData() // as there is no primary key for given dummy data, i have to remove all the data first and then load new data on every API call.
        var flight:FlightDetail!
        for item in arrFlight {
            guard let dicdata = item as? NSDictionary else {
                return
            }
            flight = NSEntityDescription.insertNewObject(forEntityName: "FlightDetail", into: self.subContext) as? FlightDetail
            flight.setFromDict(dicdata)
        }
        self.saveChildContext()
    }
    
    // MARK: - get All Flight Data
    func getFlightData() -> [FlightDetail] {
        var arrlist = [FlightDetail]()
        let fetchRequest = flightDetailTypeFetchRequest()
        
        let sortDescriptor_type_id = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor_type_id]
        do {
            arrlist = try self.subContext.fetch(fetchRequest) as! [FlightDetail]
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        return arrlist
    }
    
    func removeAllFlightData() {
        let fetchRequest = flightDetailTypeFetchRequest()
    
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            
        } catch {
            print("Delete failed: \(error.localizedDescription)")
        }
    }
    
}
