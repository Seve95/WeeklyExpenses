//
//  DetailsTableViewController.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 15/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import UIKit
import MBLibrary

class DetailsTableViewController: UITableViewController {

    
    var weeklyDetails : WeeklyExpense!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = weeklyDetails.dateString! + " - \(((weeklyDetails.getTotal()*100).rounded()/100)) €"
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyDetails.expenses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)

        cell.textLabel?.text = weeklyDetails.expenses[indexPath.row].desc
        cell.detailTextLabel?.text = "\(weeklyDetails.expenses[indexPath.row].expense.toString())"
        
        return cell
    }
}
