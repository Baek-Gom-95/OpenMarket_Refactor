//
//  NetworkManager.swift
//  OpenMarket_Refactor
//
//  Created by Baek on 2022/11/30.
//

import Foundation

class NetworkManager {
    let session = URLSession(configuration: .default)
    
    func checkHealth(by url: String, completion: @escaping (Result<Int, CustomError>) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(ReportError.checkHealth)
                completion(.failure(.unkownError))
                return
            }
            
            guard let safeData = data else {
                print(ReportError.checkHealth)
                completion(.failure(.unkownError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,200 == response.statusCode else {
                print(ReportError.checkHealth)
                completion(.failure(.unkownError))
                return
            }
            
            let data = String(decoding: safeData, as: UTF8.self)
            print(data)
            let responseData = response.statusCode
            completion(.success(responseData))
        }.resume()
    }
}
