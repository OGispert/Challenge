//
//  CountriesViewController.swift
//  WalmartChallenge
//
//  Created by ogisq on 8/25/22.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var countriesTableView: UITableView!

    private let cellIdentifier = "CountryTableViewCell"
    private var countries = Countries()
    private var allCountries = Countries()


    /// Method to get the instance of the view controller.
    /// - Returns: CountriesViewController
    static func getInstance() -> CountriesViewController? {
        let storyboard = UIStoryboard(name: "CountriesViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "CountriesViewController") as? CountriesViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCountries {
            DispatchQueue.main.async {
                self.countriesTableView.reloadData()
            }
        }
    }

    private func setupView() {
        searchBar.delegate = self
        searchBar.searchTextField.placeholder = Constants.searchPlaceholder
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                                    forCellReuseIdentifier: cellIdentifier)
    }

    private func getCountries(completion: @escaping () -> Void) {
        NetworkHelper.getCountries { countries, _ in
            guard let countries = countries else {
                self.showErrorAlert()
                return
            }
            self.countries = countries
            self.allCountries = countries
            completion()
        }
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: Constants.anErrorOccurred,
                                      message: Constants.tryAgain, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.isOk, style: .default, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UISearchBar delegate methods
extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredCountries = self.allCountries
        if !searchText.isEmpty {
            self.countries = filteredCountries.filter {
                ($0.name?.lowercased().hasPrefix(searchText.lowercased()) ?? false) ||
                ($0.capital?.lowercased().hasPrefix(searchText.lowercased()) ?? false)
            }
        } else {
            self.countries = self.allCountries
        }

        self.countriesTableView.reloadData()
    }
}

// MARK: - TableView delegate methods
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = countriesTableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                             for: indexPath) as? CountryTableViewCell {
            let name = countries[indexPath.row].name ?? ""
            let region = countries[indexPath.row].region ?? ""
            cell.configureCellElements(countryLabel: name + ", " + region,
                                       codeLabel: countries[indexPath.row].code ?? "",
                                       capitalLabel: countries[indexPath.row].capital ?? "")
            return cell
        }
        return UITableViewCell()
    }
}
