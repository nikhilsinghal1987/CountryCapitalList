//
//  CityListViewModal.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import Foundation

struct CityListModel {
    let capital: String
    let code: String
    let name: String
    let region: String

    init?(cityListModel: CitiesModal){
        self.name =  cityListModel.name ?? ""
        self.code =  cityListModel.code ?? ""
        self.capital =  cityListModel.capital ?? ""
        self.region =  cityListModel.region?.rawValue ?? ""
    }
}

class CityListViewModal: ObservableObject {
    let manager: NetworkServicesProtocol

    var cities = [CityListModel]()
    private var backupCites = [CityListModel]()
    @Published var finishedLoading: Bool?
    @Published var fetchCitiesError: NetworkRequestError?

    init(networkManager: NetworkServicesProtocol = NetworkManager.shared) {
        manager = networkManager
    }

    func fetchCities() {
        manager.getAllCities { [weak self] result in
            switch result {

            case .success(let cities):
                self?.convertCityListModal(citiesToMap: cities)
            case .failure(let error):
                self?.fetchCitiesError = error
            }
        }
    }

    private func convertCityListModal(citiesToMap: [CitiesModal]) {
        backupCites = citiesToMap.compactMap({ $0 }).compactMap({ CityListModel(cityListModel: $0) })
        self.cities = backupCites
        DispatchQueue.main.async {
            self.finishedLoading = true
        }

    }

    func filterDataForSearch(term: String?) {
        guard let searchText = term,
              !(searchText.isEmpty)
        else {
            cities = backupCites
            DispatchQueue.main.async {
                self.finishedLoading = true

            }
            return
        }

        cities = backupCites.filter { $0.name.contains(searchText) || $0.capital.contains(searchText) }
        DispatchQueue.main.async { [self] in
            self.finishedLoading = true

        }
    }

}
