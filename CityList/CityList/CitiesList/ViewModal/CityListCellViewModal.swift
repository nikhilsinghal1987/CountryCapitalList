//
//  CityListCellViewModal.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import UIKit

class CityListCellViewModal: ObservableObject {
    var cityData: CityListModel

    init(cityData: CityListModel) {
        self.cityData = cityData
    }

}

