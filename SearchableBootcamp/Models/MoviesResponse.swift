//
//  MoviesResponse.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let genre_ids: [Int]
    let release_date: String
    
    var genres: [Genre] {
        return genre_ids.map { Genre(rawValue: $0) }
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
