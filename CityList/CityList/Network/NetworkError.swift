//
//  NetworkError.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import Foundation

enum NetworkRequestError: Error {
    case jsonParseError
    case apiError(String)
    case networkNotReachable
    case genericError(String)
    case sessionExpired
    case noDataFound

    var title: String {
        switch self {
        case .jsonParseError:
            return "Data error"

        case .apiError(let description), .genericError(let description):
            return "Request Failed - Error \(description)"

        case .networkNotReachable:
            return "No Internet"

        case .sessionExpired:
            return "Expired Session"

        case .noDataFound:
            return "No Data Found"
        }
    }

    var message: String {
        switch self {

        case .jsonParseError, .apiError(_), .genericError(_) :
            return "Something went wrong please try again later"

        case .networkNotReachable:
            return "You are not connected to internet, please check your internet connection and try again"

        case .sessionExpired:
            return "Your session has expired. Please login again to continue"

        case .noDataFound:
            return "No Result found."
        }
    }
}
