//
//  MoviesManager.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import Foundation
import SwiftUI

// 'MoviesManager' is an actor class responsible for fetching movie data asynchronously.
// It ensures safe, concurrent access to its methods and properties.
actor MoviesManager {
    
    // Asynchronous function to fetch movies from the TMDb API.
    func fetchMovies() async throws -> [Movie] {
        // Your TMDb API key (replace this with a valid key if needed).
        let apiKey = ""  // Replace with your own TMDb API key
        
        // Constructing the URL to discover movies using the provided API key.
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)"
        
        // Ensure the URL is valid; if not, return an empty array of movies.
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            // Perform a network request to fetch the data asynchronously using URLSession.
            // The URLSession data method returns both the data and the URL response.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the JSON response into a MovieResponse object using JSONDecoder.
            let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            
            // Return the array of movies found in the 'results' field of the decoded response.
            return decodedResponse.results
        } catch {
            // In case of any error, print the error message to the console.
            print("error = \(error)")
            
            // Throw a custom URLError indicating a bad server response.
            throw URLError(.badServerResponse)
        }
    }
}

struct MoviesManagerKey: EnvironmentKey {
    static let defaultValue = MoviesManager()
}

extension EnvironmentValues {
    var moviesManager: MoviesManager {
        get { self [MoviesManagerKey.self] }
        set { self[MoviesManagerKey.self] = newValue }
    }
}
