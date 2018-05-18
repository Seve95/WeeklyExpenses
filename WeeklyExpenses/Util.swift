//
//  Util.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 15/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import Foundation

func getLastWeeklyExpense (_ weeklyArray : [WeeklyExpense]) -> WeeklyExpense! {
    if(weeklyArray.isEmpty) {
        return nil
    } else {
        var tmp = weeklyArray[0]
        for ex in weeklyArray {
            if (tmp.week?.timeIntervalSinceNow.isLess(than: (ex.week?.timeIntervalSinceNow)!))! {
                tmp = ex
            }
        }
        return tmp
    }
}

fileprivate let dayTime : Double = 60*60*24

extension Date {
    
    func isDifferentWeekOfYear(from: Date) -> Bool {
        let cal = Calendar.current
       return cal.component(.weekOfYear, from: self) != cal.component(.weekOfYear, from: from) || cal.component(.year, from: self) != cal.component(.year, from: from)
    }
    
    func startOfWeek() -> Date {
        let cal = Calendar.current
        let dayToSub  = cal.component(.weekday, from: self) - 2
        return cal.startOfDay(for: self.addingTimeInterval(-dayTime * Double(dayToSub)))
    }
    
}
