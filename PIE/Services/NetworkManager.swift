//
//  NetworkManager.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation
import UIKit


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
                return
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
    
//    func loadImageForUrl(urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
//        if let image = imageCache.object(forKey: urlString as NSString) {
//            completion(.success(image))
//        } else {
//            let url = URL(string: urlString)!
//
//            let dataTask = session.dataTask(with: url) { data, response, error in
//
//                if let error = error {
//                    completion(.failure(.networkError(error)))
//                    return
//                }
//
//                let image = UIImage(data: data!)
//                imageCache.setObject(image!, forKey: urlString as NSString)
//
//                completion(.success(image!))
//            }
//            dataTask.resume()
//        }
//    }
    

    
    
}
