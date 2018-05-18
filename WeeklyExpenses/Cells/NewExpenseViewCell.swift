//
//  NewExpenseViewCell.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 14/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import UIKit

class NewExpenseViewCell: UITableViewCell {

    @IBOutlet weak var expenseText: UITextField!
    @IBOutlet weak var descText: UITextField!
    
    //Need reference to tableViewController to add new expenseCell and refresh
    
    @IBAction func addNewExpense(_ sender: Any) {
        
    }
}
