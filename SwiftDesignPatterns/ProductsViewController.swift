//
//  ProductsViewController.swift
//  SwiftDesignPatterns
//
//  Created by user on 7/13/15.
//  Copyright © 2015 someCompanyNameHere. All rights reserved.
//

import UIKit

//create a closure for logging products
var handler = { (p:Product) in print("Change: \(p.name) \(p.stockLevel) items in stock")}

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct Constants {
        static let reuseId = "ProductTableCellID"
    }

    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var products = [

        Product(name: "Kayak", description: "A boat for one person", category: "Watersports", price:275.0,stockLevel: 10),
        Product(name: "Lifejacket", description: "Protective and fashionable", category: "Watersports", price:48.95, stockLevel: 14),
        Product(name: "Soccer Ball", description: "FIFA-approved size and weight", category: "Soccer", price:19.50, stockLevel: 32),
        Product(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price:34.95, stockLevel: 1),
        Product(name: "Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price:79500.0,stockLevel: 4),
        Product(name: "Thinking Cap", description: "Improve your brain efficiency by 75%", category: "Chess", price:16.0, stockLevel: 8),
        Product(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category:  "Chess", price:29.95, stockLevel: 3),
        Product(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price:75.0, stockLevel: 2),
        Product(name: "Bling-Bling King", description:"Gold-plated, diamond-studded King", category:  "Chess", price:1200.0, stockLevel: 4)]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        displayStockTotal()
    }

    func configureTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.reuseId)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    func displayStockTotal() {

//        let level = products.reduce(0) {return $0 + $1.stockLevel}
//        let value = products.reduce(0.0) {return $0 + $1.stockValue}

//        let finalTotal:(Int, Double) = products.reduce((0, 0.0),
//            combine: {(totals, product) -> (Int, Double) in
//                return (
//                    totals.0 + product.stockLevel,
//                    totals.1 + product.stockValue
//                )
//        })

        let finalTotal:(Int, Double) = products.reduce((0, 0.0),
            combine: {
                return ($0.0 + $1.stockLevel, $0.1 + $1.stockValue)
        })

        totalStockLabel.text = "\(finalTotal.0) products in stock" + "Total value: \(Utils.currencyStringFromNumber(finalTotal.1))"

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.reuseId) as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.descriptionLabel.text = product.productDescription
        cell.nameLabel.text = product.name
        cell.stockStepper.value = Double(product.stockLevel)
        cell.textField.text = String(product.stockLevel)
        return cell
    }

    @IBAction func stockLevelDidChange(sender:AnyObject) {
        if var currentCell =  sender as? UIView {

            while(true) {
                
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableViewCell {

                    if let product = cell.product {

                        if let stepper =  sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textField = sender as? UITextField {
                            if let newValue = Int(textField.text!) {
                                product.stockLevel = newValue
                            }
                        }

                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.textField.text = String(product.stockLevel)
                        productLogger.logItem(product)
                    }
                }

                break;
            }
        }
        displayStockTotal()
    }
}







































