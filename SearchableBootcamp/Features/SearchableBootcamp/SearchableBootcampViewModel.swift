//
//  SearchableBootcamoViewModel.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import SwiftUI

final class SearchableBootcampViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var movies: [Movie] = []
    
    func fetchMovies() async{
        let apiKey = "5f81bcbac7153e9626b510f45e5e36c3"  // Replace with your own TMDb API key
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            await MainActor.run(body: {
                movies = decodedResponse.results
                print("Movies = \(movies)")
            })
        }catch {
            print("error =\(error)")
        }
    }
}


