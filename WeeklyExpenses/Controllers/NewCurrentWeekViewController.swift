//
//  NewCurrentWeekViewController.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 11/04/2019.
//  Copyright © 2019 Nicola Severini. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NewCurrentWeekViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var weekTableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var currentWeek : WeeklyExpense!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weekTableView.delegate = self
        weekTableView.dataSource = self
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentWeek = getLastWeeklyExpense(WeeklyExpense.all)
        if currentWeek?.week?.isDifferentWeekOfYear(from: Date()) ?? true {
            currentWeek = WeeklyExpense(Date())
            currentWeek.saveToRealm()
        }
        weekTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return currentWeek.expenses.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateTotCell", for: indexPath)
            
            cell.textLabel?.text = currentWeek.dateString! + " - " + currentWeek.sundayDateString!
            cell.detailTextLabel?.text = "\(currentWeek.getTotal().toPriceString())"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
            cell.textLabel?.text = currentWeek.expenses[indexPath.row].desc
            cell.detailTextLabel?.text = "\(currentWeek.expenses[indexPath.row].expense.toPriceString())"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            if(indexPath.section == 1) {
                if(currentWeek.deleteExpense(expense: currentWeek.expenses[indexPath.row])) {
                    weekTableView.deleteRows(at: [indexPath], with: .automatic)
                    self.weekTableView.reloadData()
                }
            }
        }
    
}
