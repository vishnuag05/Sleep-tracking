//
//  SleepCell.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit

class SleepCell: UITableViewCell {
    let labelDate: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    let labelTimeInterval: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setUpViews() {
        selectionStyle = .none
        labelDate.pin(to: contentView, topEdge: 24, bottomEdge: 24, leadingEdge: 16)
        labelDate.text = "28th April(Sun)"
        labelTimeInterval.pin(to: contentView, topEdge: 24, bottomEdge: 24, trailingEdge: 16)
        labelTimeInterval.text = "11:00 PM - 7:00 AM"
    }
    func configure(sleep: Sleep) {
        guard let start = sleep.startDate as Date?, let end = sleep.endDate as Date? else { return }
        labelDate.text = String(format: "%@ (%@)", start.convertDateToMonthDay, start.dayOfTheWeek())
        labelTimeInterval.text = String(format: "%@ - %@", start.convertDateToTime, end.convertDateToTime)
    }
}
