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
    
    func dataTask(by url: String, completion: @escaping (Result<ProductListResponse, CustomError>) -> ()) {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(CustomError.statusCodeError))
            }
            
            if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(ProductListResponse.self, from: data)
                    completion(.success(decodeData))
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
