//
//  TimeTool.swift
//  ipadSwiftDemo
//
//  Created by fantasy on 17/3/7.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

class TimeTool: NSObject {

    static let tool = TimeTool()

    func convertTimeIntToTimeString(time: Int64) -> String {

        let hour = time / 3600
        let hourRemain = time % 3600
        let totalMin = hourRemain / 60
        let totalSec = hourRemain % 60

        var timeString: String
        if hour == 0 {
            timeString = String(format: "%.2d:%.2d", totalMin, totalSec)
        } else {
            timeString = String(format: "%.2d:%.2d:%.2d", hour, totalMin, totalSec)
        }
        return timeString
    }
}
