//
//  APIManager.swift
//  Cats
//
//  Created by aljon antiola on 10/11/24.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func fetch<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.unknown))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }
        task.resume()
    }
}

enum APIError: Error {
    case badURL
    case decodingError
    case unknown
}

