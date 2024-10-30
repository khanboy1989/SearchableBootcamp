//
//  SearchableBootcampView.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import SwiftUI

struct SearchableBootcampView: View {
    
    // Initializing the ViewModel to manage the state and logic of the view.
    @StateObject var viewModel = SearchableBootcampViewModel()
    
    var body: some View {
        NavigationStack {
            // Display a list of movies.
            // If the user is searching, show filteredMovies, otherwise show all movies.
            List(viewModel.isSearching ? viewModel.filteredMovies : viewModel.movies) { movie in
                VStack(alignment: .leading) {
                    // Movie title displayed as a headline.
                    Text(movie.title)
                        .font(.headline)
                    // Display the release date of the movie.
                    Text("Release Date: \(movie.release_date)")
                    // Display the genres of the movie, joined by commas.
                    Text("Genres: \(movie.genres.map { $0.name }.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary) // Lighter text color for the genres.
                }
            }
            // Modifier to make the list searchable.
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: Text("Search Movies"))
            
            // Modifier to define the search scope, allowing the user to filter by genres.
            .searchScopes($viewModel.searchScope, scopes: {
                // Dynamically create a Text view for each search scope (genre).
                ForEach(viewModel.allSearchScopes, id: \.self) { scope in
                    // Display the title for each search scope and use the .tag() modifier to bind it.
                    Text(scope.title)
                        .tag(scope)
                }
            })
            
            // Set the title of the navigation bar.
            .navigationTitle("Movies")
            
            // Asynchronously fetch movies when the view appears (on task).
            .task {
                await viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    // Preview to test how the view looks in Xcode.
    SearchableBootcampView()
}
