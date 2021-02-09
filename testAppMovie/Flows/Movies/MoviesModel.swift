//
//  MoviesModel.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import Foundation

struct MoviesModel: Decodable {
    
    var page: Int
    var results: [Results]
    
    static var defaultPlaceholder: Self = {
        return MoviesModel(page: 0, results: [])
    }()
    
}

struct Results: Decodable, Hashable {
    var poster_path: String
    var overview: String
    var release_date: String
    var id: Int
    var title: String
    var original_language: String
}
