//
//  RegistrableCellProtocol.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import UIKit

protocol RegistrableCellProtocol: UITableViewCell {
    static var defaultIdentifier: String { get }
}

extension RegistrableCellProtocol {
    static var defaultIdentifier: String {
        return String(describing: self)
    }
}
