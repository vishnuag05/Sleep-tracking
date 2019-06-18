//
//  CMMotionActivitySleep.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit
import CoreMotion

class ActivityStationary: CustomStringConvertible {
    let endDate: Date
    let startDate: Date
    init(end: Date, start: Date) {
        endDate = end
        startDate = start
    }
    var description: String {
        return "Start "+startDate.description+" End "+endDate.description
    }
}
