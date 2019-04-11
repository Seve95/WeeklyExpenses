////
////  NewExpenseViewCell.swift
////  WeeklyExpenses
////
////  Created by Nicola Severini on 14/11/17.
////  Copyright © 2017 Nicola Severini. All rights reserved.
////
//
//import UIKit
//
//class NewExpenseViewCell: UITableViewCell {
//
//    @IBOutlet weak var expenseText: UITextField!
//    @IBOutlet weak var descText: UITextField!
//    var currentWeekTable : CurrentWeekViewController!
//    
//    
//    
//    @IBOutlet weak var addButton: UIButton!
//    
//    @IBAction func addNewExpense(_ sender: Any) {
//        
//        guard let desc = descText.text, !desc.isEmpty else {
//            let alert = UIAlertController(title: "Errore!", message: "Descrizione non inserita", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//                NSLog("The \"OK\" alert occured.")}))
//                currentWeekTable.present(alert, animated: true)
//            return
//        }
//        
//        guard let exp = expenseText.text, !exp.isEmpty, let exD = exp.toDouble() else {
//             let alert = UIAlertController(title: "Errore!", message: "Spesa non inserita", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//                NSLog("The \"OK\" alert occured.")}))
//            currentWeekTable.present(alert, animated: true)
//            return
//        }
//        
//        let ex = Expense(desc, exD)
//        currentWeekTable.currentWeek.addExpense(expense: ex)
//        currentWeekTable.tableView.reloadData()
//        
//    }
//    
//        
//}
//
