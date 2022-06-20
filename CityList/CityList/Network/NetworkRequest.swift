//
//  NetworkRequest.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import Foundation

enum Requests {
    case cities

    
    var path: String {
        switch self {
        case .cities:
            return "countries.json"
        }
    }
    
    var requestMethod: String {
        switch self {
        case .cities:
            return "GET"
        }
    }
}

struct NetworkRequest <T: Decodable> {
    let baseURL: String = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/"
//    let apiKey = "2411F29D-7DFF-4286-9A83-7B591E3E826A"
    var request: Requests
    
    init(request: Requests) {
        self.request = request
    }
    
    // MARK: - Public methods
    func execute(completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: baseURL + request.path) else {
            completion(.failure(NetworkRequestError.genericError("Invalid URL")))
            return
        }
        
        performNetworkRequest(with: createURLRequest(url: url)) { result in

            switch result {
            case .success(let responseData):
                guard let decodedData = decodeData(input: responseData, withType: T.self) else {
                    completion(.failure(NetworkRequestError.jsonParseError))
                    return
                }
                
                completion(.success(decodedData))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createURLRequest(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.requestMethod
        return urlRequest
    }
}

// MARK: Private methods
extension NetworkRequest {
    /*
    private func performNetworkRequest(with urlRequest: URLRequest, completion: @escaping ((Result<T, Error>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let responseData = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkRequestError.genericError("Network Error")))
                }
                
                return
            }
            
            guard let decodedData = decodeData(input: responseData, withType: T.self) else {
                completion(.failure(NetworkRequestError.jsonParseError))
                return
            }
            
            completion(.success(decodedData))
        }
        task.resume()
    } */
    
    private func performNetworkRequest(with urlRequest: URLRequest, completion: @escaping ((Result<Data, Error>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let responseData = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkRequestError.genericError("Network Error")))
                }
                
                return
            }
            completion(.success(responseData))
        }
        task.resume()
    }
    
    private func decodeData<T: Decodable>(input: Data, withType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: input)
            return decodedData
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
