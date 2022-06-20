//
//  MockNetworkManager.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import Foundation

class MockNetworkManager: NetworkServicesProtocol {

    static let shared = MockNetworkManager()
    
    private init() {}

    func getAllCities(completion: @escaping ((Result<[CitiesModal], NetworkRequestError>) -> Void)) {
        readFileData(fileName: "CityList") { [weak self] isSuccess, fileData in
            guard let data = fileData,
                  isSuccess,
                  let decodedData = self?.decodeData(input: data, withType: [CitiesModal].self)
            else {
                completion(.failure(.jsonParseError))
                return
            }
            
            completion(.success(decodedData))
        }
    }

}

extension MockNetworkManager {
    
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
    
    private func readFileData(fileName: String, completion: @escaping (_ isSuccess: Bool, _ parsedData: Data?) -> Void) {
        if let path = pathFor(file: fileName) {
            do {
                let filedata = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(true , filedata)
            } catch let error {
                debugPrint(error.localizedDescription)
                completion(false , nil)
            }
        } else {
            completion(false , nil)
        }
    }
    
    private func pathFor(file: String) -> String? {
        return Bundle.main.path(forResource: file, ofType: "json")
    }
}
