//
//  AddExpenseViewController.swift
//  WeeklyExpenses
//
//  Created by Nicola Severini on 11/04/2019.
//  Copyright © 2019 Nicola Severini. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AddExpenseViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var expenseField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var expenseImage: UIImageView!
    
    var currentWeek : WeeklyExpense!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseField.placeholder = "$"
        expenseField.keyboardType = UIKeyboardType.decimalPad
        expenseField.delegate = self
        
        descriptionField.placeholder = "Description"
        descriptionField.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentWeek == nil {
            currentWeek = getLastWeeklyExpense(WeeklyExpense.all)
            
            if currentWeek?.week?.isDifferentWeekOfYear(from: Date()) ?? true {
                currentWeek = WeeklyExpense(Date())
                currentWeek.saveToRealm()
            }
        }
    }
    
    
    @IBAction func addNewExpense(_ sender: Any) {
        guard let desc = descriptionField.text, !desc.isEmpty else {
            let alert = UIAlertController(title: "Errore!", message: "Descrizione non inserita", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")}))
            self.present(alert, animated: true)
            return
        }
        
        guard let exp = expenseField.text, !exp.isEmpty, let exD = exp.toDouble() else {
            let alert = UIAlertController(title: "Errore!", message: "Spesa non inserita", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")}))
            self.present(alert, animated: true)
            return
        }
        
        descriptionField.text = ""
        expenseField.text = ""
        
        let ex = Expense(desc, exD)
        currentWeek.addExpense(expense: ex)
    }
    
    
    @IBAction func tapAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
}
