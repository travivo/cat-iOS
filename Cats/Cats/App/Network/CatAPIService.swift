//
//  CatAPIService.swift
//  Cats
//
//  Created by aljon antiola on 10/11/24.
//

import Foundation

struct CatAPIEndpoints {
    static let baseFactURL = "https://meowfacts.herokuapp.com/"
    static let baseImageURL = "https://api.thecatapi.com/v1/images/search"
    
    static func factURL(withCount count: Int = 10) -> String {
        return "\(baseFactURL)?count=\(count)"
    }
    
    static func imageURL(withLimit limit: Int = 10) -> String {
        return "\(baseImageURL)?limit=\(limit)"
    }
}


class CatAPIService {
    
    private let apiManager = APIManager.shared
    
    // Fetch random cat facts
    func fetchCatFact(count: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        let factURL = CatAPIEndpoints.factURL(withCount: count)
        
        apiManager.fetch(from: factURL) { (result: Result<CatFactResponse, Error>) in
            switch result {
            case .success(let factResponse):
                completion(.success(factResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Fetch random cat images
    func fetchCatImage(limit: Int, completion: @escaping (Result<[CatImage], Error>) -> Void) {
        let imageURL = CatAPIEndpoints.imageURL(withLimit: limit)
        
        apiManager.fetch(from: imageURL) { (result: Result<[CatImage], Error>) in
            switch result {
            case .success(let imageUrls):
                completion(.success(imageUrls))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

