//
//  CountryTableViewCell.swift
//  WalmartChallenge
//
//  Created by ogisq on 8/25/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak private var countryLabel: UILabel!
    @IBOutlet weak private var codeLabel: UILabel!
    @IBOutlet weak private var capitalLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Configuration method to display cell items
    /// - Parameters:
    ///   - countryLabel: Name string + Code string
    ///   - codeLabel: Code string
    ///   - capitalLabel: Capital string
    func configureCellElements(countryLabel: String, codeLabel: String, capitalLabel: String) {
        self.countryLabel.text = countryLabel
        self.codeLabel.text = codeLabel
        self.capitalLabel.text = capitalLabel
    }
}
