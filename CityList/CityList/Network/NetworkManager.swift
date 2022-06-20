//
//  NetworkManager.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import Foundation

class NetworkManager: NetworkServicesProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - API requests
    
    func getAllCities(completion: @escaping ((Result<[CitiesModal], NetworkRequestError>) -> Void))  {
        NetworkRequest<[CitiesModal]>(request: .cities).execute { result in
            switch result {
                
            case .success(let citiesList):
                completion(.success(citiesList))
                
            case .failure(let error):
                if let networkRequestErr = error as? NetworkRequestError {
                    completion(.failure(networkRequestErr))
                } else {
                    let nserror = error as NSError
                    
                    // Individual errors can be handled
                    if nserror.code == 403 {
                        completion(.failure(NetworkRequestError.sessionExpired))
                    } else {
                        completion(.failure(.apiError(error.localizedDescription)))
                    }
                }
            }
        }
    }
}

// MARK: - Private Methods
extension NetworkManager {
    
    private func performNetworkRequest(with url: URL, completion: @escaping ((Result<Data, NetworkRequestError>) -> Void)) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let responseData = data else {
                if let error = error {
                    completion(.failure(.apiError(error.localizedDescription)))
                } else {
                    completion(.failure(.genericError("API call failed: Unknown error")))
                }
                
                return
            }
            
            completion(.success(responseData))
        }
        
        task.resume()
    }
}
