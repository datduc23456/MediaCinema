//
//  Genre.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation
import RealmSwift

struct GenreResponse: Codable {
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init() {
        self.id = 0
        self.name = "All genres"
    }
}
