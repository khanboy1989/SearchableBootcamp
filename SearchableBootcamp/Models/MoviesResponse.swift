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
}

struct MovieResponse: Codable {
    let results: [Movie]
}
