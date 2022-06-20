//
//  CityListViewController.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import UIKit
import Foundation
import Combine


class CityListViewController: UIViewController {

    var viewModel: CityListViewModal


    private var subscriptions = Set<AnyCancellable>()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let citySearchController = UISearchController(searchResultsController: nil)

    var searchText = "" {
        didSet {
            viewModel.filterDataForSearch(term: searchText)
        }
    }


    lazy var cityListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isOpaque = true
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        viewModel.fetchCities()
    }

    init(viewModel: CityListViewModal = CityListViewModal()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addViews()
        setConstraints()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        title = "Cities"
        view.addSubview(cityListTableView)
        showActivity()
        cityListTableView.dataSource = self
        cityListTableView.delegate = self
        cityListTableView.register(CitiesListCell.self)
        setupSearchBar()
    }

    private func setupSearchBar() {
        citySearchController.searchBar.delegate = self
        citySearchController.searchResultsUpdater = self
        citySearchController.obscuresBackgroundDuringPresentation = false


        cityListTableView.tableHeaderView = citySearchController.searchBar
    }

    private func setConstraints() {
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            cityListTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            cityListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$finishedLoading.sink { [weak self] _ in
            self?.hideActivity()
            self?.cityListTableView.reloadData()
        }.store(in: &subscriptions)


        viewModel.$fetchCitiesError.sink { [weak self] fetchError in
            guard let error = fetchError else {
                return
            }
            self?.hideActivity()
            self?.cityListTableView.reloadData()
            self?.showAlert(for: error)
        }.store(in: &subscriptions)

    }

}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cities.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let citiesListCell = cityListTableView.dequeueReusableCell(withIdentifier: CitiesListCell.defaultIdentifier, for: indexPath) as? CitiesListCell,
            indexPath.row < viewModel.cities.count
        else {
            return UITableViewCell()
        }
        citiesListCell.selectionStyle = .none

        let cellViewModel = CityListCellViewModal(cityData: viewModel.cities[indexPath.row])
        citiesListCell.cellViewModel = cellViewModel

        return citiesListCell
    }
}

extension CityListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Nothing we are doing on selection
    }
}

// MARK: - UISearchBar Delegate
extension CityListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchBarText = searchBar.text {
            searchText = searchBarText
        }
    }

}

// MARK: - UISearchBar Updating Delegate
extension CityListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        if let searchBarText = searchBar.text {
            searchText = searchBarText
        }
    }

}
