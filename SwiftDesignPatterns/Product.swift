//
//  Product.swift
//  SwiftDesignPatterns
//
//  Created by user on 7/13/15.
//  Copyright © 2015 someCompanyNameHere. All rights reserved.
//

import UIKit

class Product:NSObject, NSCopying {

    //Readable throughout the module, but only writeable from within this file.
    private (set) var name:String?
    private (set) var productDescription:String?
    private (set) var category:String?
    private var stockLevelBackingValue:Int = 0
    private var priceBackingValue:Double = 0.0


    init(name:String, description:String, category:String, price: Double, stockLevel:Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        super.init()
        self.price = price
        self.stockLevel = stockLevel

    }

    var stockLevel:Int {
        get { return stockLevelBackingValue}
        set { stockLevelBackingValue = max(0, newValue)}
    }

    // Readable throughout the module, but only writeable from within this file.
    private (set) var price:Double {
        get { return priceBackingValue}
        set { priceBackingValue = max(1, newValue)}
    }

    var stockValue:Double {
        get {
            return price * Double(stockLevel)
        }
    }

    func copyWithZone(zone: NSZone) -> AnyObject {
        return Product(name: self.name!, description: self.productDescription!, category: self.category!, price: self.price, stockLevel: self.stockLevel)
    }
    
}
