//
//  MotionHelper.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit
import CoreMotion
class MotionHelper {
    static let shared = MotionHelper()
    let motionManager = CMMotionActivityManager.init()
    func processSleep() {
        var dateFrom = Date().addingTimeInterval(-7*24*60*60)
        if let dateProcessedLast = UserDefaults.standard.value(forKey: UserDefaultsKeys.lastProcessDate) as? Date {
            dateFrom = dateProcessedLast
        }
        motionManager.queryActivityStarting(from: dateFrom, to: Date(), to: OperationQueue.main) { (motions, error) in
            guard let motions = motions else { return }
            var arrActivities = [ActivityStationary]()
            for (index, motion) in motions.enumerated() {
                if motion.stationary == true {
                    arrActivities.append(ActivityStationary.init(end: (motions.count-1 != index ? motions[index+1].startDate : Date()), start: motion.startDate))
                }
            }
            if let last = motions.last {
                UserDefaults.standard.set(last.startDate, forKey: UserDefaultsKeys.lastProcessDate)
            }
            self.processActivitiesStationary(arrActivities: arrActivities)
            DispatchQueue.main.async {
                CoreDataManager.shared.saveChanges()
            }
        }
    }
    func processActivitiesStationary(arrActivities: [ActivityStationary]) {
        var startDate: Date?
        var endDate: Date?
        var activeDuration = TimeInterval()
        for (i, activity) in arrActivities.enumerated() {
            if startDate != nil {
                activeDuration += activity.startDate.timeIntervalSinceNow - arrActivities[i-1].endDate.timeIntervalSinceNow
                if activeDuration < 300 {
                    if ((activity.startDate+20*60) < activity.endDate) {
                        endDate = activity.endDate
                    } else {
                        
                    }
                } else {
                    if endDate!-3*60*60 > startDate! {
                        if let start = startDate, let end = endDate {
                            Sleep.addSleep(start: start, end: end)
                        }
                        startDate = nil
                        endDate = nil
                        activeDuration = 0
                    } else {
                        startDate = nil
                        endDate = nil
                        activeDuration = 0
                    }
                }
            } else {
                if ( activity.startDate+20*60 ) < activity.endDate {
                    startDate = activity.startDate
                    endDate = activity.endDate
                }
            }
        }
        if let start = startDate, let end = endDate {
        if end-3*60*60 > start {
            Sleep.addSleep(start: start, end: end)
            startDate = nil
            endDate = nil
            activeDuration = 0
        }
        }
    }
}
