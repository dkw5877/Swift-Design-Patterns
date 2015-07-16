//
//  ProductTableViewCell.swift
//  SwiftDesignPatterns
//
//  Created by user on 7/13/15.
//  Copyright © 2015 someCompanyNameHere. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var textField: UITextField!
    var product:Product?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
