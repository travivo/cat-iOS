//
//  CatImage.swift
//  Cats
//
//  Created by aljon antiola on 10/11/24.
//

import Foundation

struct CatImage: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}
