//
//  NetworkManager.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedManager = NetworkManager()

    lazy private var session: URLSession = {
        return URLSession(configuration: .default)
    }()

    private init() {}
    
     func performDataTask(with request: URLRequest,
                          completion: @escaping (Result<Data, AppError>) -> ()) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.networkError(error)))
            }
        
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            guard  200...299 ~= urlResponse.statusCode else {
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }

}
