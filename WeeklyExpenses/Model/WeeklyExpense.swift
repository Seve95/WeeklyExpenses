//
//  WeeklyExpense.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 14/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

fileprivate let myRealm = try! Realm()

class WeeklyExpense: Object {
    @objc private(set) dynamic var week : Date?
    private(set) var expenses = List<Expense>()
    
    var dateString : String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
       return dateFormatter.string(from: week!)
    }
    
    var sundayDateString : String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let sunday = Calendar.current.date(byAdding: Calendar.Component.day, value: 6, to: week!)
        return dateFormatter.string(from: sunday!)
    }
    
    
    static var all: [WeeklyExpense] {
        return Array(myRealm.objects(WeeklyExpense.self))
    }
    
    func deleteWeek() -> Bool {
        do {
            try myRealm.write {
                myRealm.delete(self)
            }
            return true;
        }  catch {
            return false
        }
    }
    
    func deleteExpense (expense: Expense) -> Bool {
        guard let index = expenses.index(of: expense) else {
            return false
        }
        do {
            try myRealm.write {
                expenses.remove(at: index)
            }
            return expense.deleteExpense()
        }  catch {
            return false
        }
    }
    
    init (_ week: Date?) {
        super.init()
//        let dayToSub  = Calendar.current.component(.weekday, from: week!) - 2
//        self.week = week?.addingTimeInterval(-dayTime * Double(dayToSub))
        self.week = week?.startOfWeek()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init() {
        super.init()
    }
    
    @discardableResult func saveToRealm() -> Bool {
        guard self.realm == nil else {
            return true
        }
        
        do {
            try myRealm.write {
                myRealm.add(self)
            }
            
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func set(week: Date?) -> Bool {
        // TO-DO: check day is monday
        
        if let realm = self.realm {
            do {
                try realm.write {
                    self.week = week
                }
                return true
            } catch {
                return false
            }
        } else {
            self.week = week
            return true
        }
    }
    
    @discardableResult
    func set(expenses: List<Expense>) -> Bool {
        // TODO: Filter and check that fName is correct
        
        if let realm = self.realm {
            do {
                try realm.write {
                    self.expenses = expenses
                }
                return true
            } catch {
                return false
            }
        } else {
            self.expenses = expenses
            return true
        }
    }
    
    @discardableResult
    func addExpense(expense: Expense) -> Bool {
        // TODO: Filter and check that fName is correct
        
        if let realm = self.realm {
            do {
                try realm.write {
                    self.expenses.append(expense)
                }
                return true
            } catch {
                return false
            }
        } else {
            self.expenses.append(expense)
            return true
        }
    }
    
    //Functions
    
    func getTotal() -> Double {
        var res : Double = 0
        for ex in self.expenses {
            res += ex.expense
        }
        return res
    }
    
    func getLastWeeklyExpense() -> WeeklyExpense! {
        let weeklyArray = Array(myRealm.objects(WeeklyExpense.self))
        if(weeklyArray.isEmpty) {
            return nil
        } else {
            var tmp = weeklyArray[0]
            for ex in Array(myRealm.objects(WeeklyExpense.self)) {
                if !(tmp.week?.timeIntervalSinceNow.isLess(than: (ex.week?.timeIntervalSinceNow)!))! {
                    tmp = ex
                }
            }
            return tmp
        }
    }
    
    func getDayOfMonth() -> Int {
        return Int(self.dateString!.components(separatedBy: " ")[2])!
    }
    
    func getDayOfWeek() -> Int {
        return Calendar.current.component(.weekday, from: self.week!)
    }
    
    
    
}
