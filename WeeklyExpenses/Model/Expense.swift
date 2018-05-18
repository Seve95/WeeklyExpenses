//
//  Expense.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 14/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class Expense: Object {
    @objc private(set) dynamic var desc : String?
    @objc private(set) dynamic var expense = -1.0
    
    init (_ desc: String, _ expense: Double) {
        super.init()
        self.desc = desc
        self.expense = expense
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
    
    @discardableResult
    func set(desc: String) -> Bool {
        // TODO: Filter and check that fName is correct
        
        if let realm = self.realm {
            do {
                try realm.write {
                    self.desc = desc
                }
                return true
            } catch {
                return false
            }
        } else {
            self.desc = desc
            return true
        }
    }
    
    @discardableResult
    func set(expense: Double) -> Bool {
        // TODO: Filter and check that fName is correct
        
        if let realm = self.realm {
            do {
                try realm.write {
                    self.expense = expense
                }
                return true
            } catch {
                return false
            }
        } else {
            self.expense = expense
            return true
        }
    }
    
    func deleteExpense() -> Bool {
       
        if let realm = self.realm {
            do {
                try realm.write {
                    realm.delete(self)
                }
                return true
            } catch {
                return false
            }
        } else {
            return true
        }
    }
    
}

