//
//  MainViewController.swift
//  WalmartChallenge
//
//  Created by ogisq on 8/25/22.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func viewListButtonTapped(_ sender: UIButton) {
        guard let countriesVC = CountriesViewController.getInstance() else { return }
        self.navigationController?.pushViewController(countriesVC, animated: true)
    }
}

