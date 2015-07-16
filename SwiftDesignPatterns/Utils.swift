//
//  Utils.swift
//  SwiftDesignPatterns
//
//  Created by user on 7/13/15.
//  Copyright © 2015 someCompanyNameHere. All rights reserved.
//

import Foundation


class Utils {

    class func currencyStringFromNumber(number:Double)-> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(number) ?? ""
    }
}