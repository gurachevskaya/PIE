//
//  NetworkManager.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit


protocol NetworkManagerProtocol: class {
   
}


class NetworkManager {
    
    private let session: URLSession
    
//    static let sharedManager = NetworkManager()
//    private init() {}
    
    
    init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
//    lazy private var session: URLSession = {
//        return URLSession(configuration: .default)
//    }()
    
    
    func performDataTask(with request: URLRequest,
                         completion: @escaping (Result<Data, AppError>) -> ()) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            if urlResponse.statusCode == 429 {
                completion(.failure(.tooManyRequests))
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
