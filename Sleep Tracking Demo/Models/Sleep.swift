//
//  Sleep.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit
import CoreData
@objc(Sleep)
class Sleep: NSManagedObject {
}
extension Sleep {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sleep> {
        return NSFetchRequest<Sleep>(entityName: "Sleep")
    }
    
    @NSManaged public var startDate: NSDate?
    @NSManaged public var endDate: NSDate?
}
extension Sleep {
    class func addSleep(start: Date, end: Date) {
        let sleep = Sleep(context: CoreDataManager.shared.mainManagedObjectContext)
        sleep.endDate = end as NSDate
        sleep.startDate = start as NSDate
    }
}
