//
//  CatFact.swift
//  Cats
//
//  Created by aljon antiola on 10/11/24.
//

import Foundation

struct CatFact: Decodable {
    let data: String
}

struct CatFactResponse: Decodable {
    let data: [String]
}
