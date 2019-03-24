//
//  CurrentWeekViewController.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 13/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import UIKit

class CurrentWeekViewController: UITableViewController, UITextFieldDelegate {

    var currentWeek : WeeklyExpense!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var doUpdateTable = currentWeek == nil
        currentWeek = getLastWeeklyExpense(WeeklyExpense.all)

        if currentWeek?.week?.isDifferentWeekOfYear(from: Date()) ?? true {
            currentWeek = WeeklyExpense(Date())
            currentWeek.saveToRealm()
            doUpdateTable = true
        }
        
        if doUpdateTable {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return currentWeek == nil ? 0 : 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return currentWeek.expenses.count
        case 2:
            return 1
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateTotCell", for: indexPath) as! DateViewCell
            cell.dateLabel.text = currentWeek.dateString! + " - " + currentWeek.sundayDateString!
            cell.totLabel.text = "\(currentWeek.getTotal().toString()) €"
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
            cell.textLabel?.text = currentWeek.expenses[indexPath.row].desc
            cell.detailTextLabel?.text = "\(currentWeek.expenses[indexPath.row].expense.toString()) €"
            return cell
        } else {
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "newExpenseCell", for: indexPath) as! NewExpenseViewCell
            cell.currentWeekTable = self
            cell.descText.text = ""
            cell.expenseText.text = ""
            
            cell.descText.delegate = self
            cell.expenseText.delegate = self
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return indexPath.section == 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1) {
            if(currentWeek.deleteExpense(expense: currentWeek.expenses[indexPath.row])) {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.reloadData()
            }
        }
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
