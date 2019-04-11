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
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
}

extension Double {
    func toString() -> String {
        return String(format:"%.2f", self)
    }
    
    func toPriceString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        return formatter.string(from: NSNumber(value: self))! 
    }
}

extension String {
    func toDouble() -> Double! {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        return formatter.number(from: self) as? Double
    }
}

func numberOfMonths(_ weeklyArray : [WeeklyExpense]) -> Int {
    if(weeklyArray.count > 0) {
        let calendar = Calendar.current
        var components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: weeklyArray[0].week!)
        var currentMonth = components.month
        var res = 1
        for w in weeklyArray {
            components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: w.week!)
            if(currentMonth != components.month) {
                currentMonth = components.month
                res += 1
            }
        }
        return res
    } else { return 0 }
}

func organizedExpenses (_ weeklyArray : [WeeklyExpense]) -> [[WeeklyExpense]] {
    if (weeklyArray.count > 0) {
        print(weeklyArray.count)
        print(numberOfMonths(weeklyArray))

        var res = Array(repeating: [WeeklyExpense](), count: numberOfMonths(weeklyArray))
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: weeklyArray[0].week!)
        var currentMonth = components.month
        var i = 0
        
        for w in weeklyArray {
            components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: w.week!)
            if(currentMonth == components.month) {
                res[i].append(w)
            } else {
                currentMonth = components.month
                i += 1
                res[i].append(w)
            }
        }
        
        return res
    } else { return [[]] }
}
