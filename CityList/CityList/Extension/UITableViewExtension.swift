//
//  UITableViewExtension.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import UIKit

extension UITableView {
    func register<T: RegistrableCellProtocol>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }
}
