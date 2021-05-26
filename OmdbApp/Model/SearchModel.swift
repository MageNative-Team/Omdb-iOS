//
//  SearchData.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import Foundation

// MARK: - Search
struct SearchDataModel:Codable {
    var title, year, imdbID: String?
    var type: String?
    var poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title         = "Title"
        case year          = "Year"
        case imdbID        = "imdbID"
        case type          = "Type"
        case poster        = "Poster"
    }
}




