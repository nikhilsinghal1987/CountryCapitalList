//
//  NetworkServicesProtocol.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import Foundation

protocol NetworkServicesProtocol {
    func getAllCities(completion: @escaping ((Result<[CitiesModal], NetworkRequestError>) -> Void))
}
