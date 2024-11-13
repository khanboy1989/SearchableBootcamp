//
//  ContentView.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.moviesManager) var moviesManager  // Corrected environment key name
    @State private var movies: [Movie]? = nil ?? []        // `movies` should be a @State property

    var body: some View {
        VStack {
            Text("Movies Count: \(movies?.count)")
            if let movies {
                List(movies, id: \.id) { movie in
                    Text(movie.title)
                }
            }
            
        }
        .task {
            movies = try? await moviesManager.fetchMovies()
        }
    }
}

#Preview {
    ContentView()
}
