//
//  HistoryTableViewController.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 14/11/17.
//  Copyright © 2017 Nicola Severini. All rights reserved.
//

import UIKit
import MBLibrary

class HistoryTableViewController: UITableViewController {
    
    var history : [WeeklyExpense]!
    var historyMonth : [[WeeklyExpense]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        history = WeeklyExpense.all.reversed()
        let indexLast = history.index(of: getLastWeeklyExpense(history))
        history.remove(at: indexLast!)
        historyMonth = organizedExpenses(self.history)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return historyMonth.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.historyMonth[section]
        return section[0].week?.month
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.historyMonth[section]
        return section.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)

        cell.textLabel?.text = historyMonth[indexPath.section][indexPath.row].dateString
        cell.detailTextLabel?.text = "\(((historyMonth[indexPath.section][indexPath.row].getTotal()*100).rounded()/100)) €"

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let detailsController = segue.destination as! DetailsTableViewController
            detailsController.weeklyDetails = historyMonth[(self.tableView.indexPathForSelectedRow?.section)!][(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
