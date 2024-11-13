//
//  SearchableBootcampViewModel.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import SwiftUI
import Combine

final class SearchableBootcampViewModel: ObservableObject {
    
    // The manager responsible for fetching movies (e.g., from an API). & Injected as moviesManager by using EnvironmentKeys and EnviromentValues
    private let moviesManager: MoviesManager = MoviesManager()

    // Published properties to bind to the UI.
    
    // Holds the user's search input.
    @Published var searchText: String = ""
    
    // Array of all movies fetched from the MoviesManager.
    @Published private(set) var movies: [Movie] = []
    
    // Array of filtered movies, updated based on searchText and searchScope.
    @Published private(set) var filteredMovies: [Movie] = []
    
    // Array of unique genres derived from the movies.
    @Published private(set) var genres: [Genre] = []
    
    // Array of all search scope options, including the "All" option and the first 4 genres.
    @Published private(set) var allSearchScopes: [SearchScopeOption] = []
    
    // Holds the current search scope, defaulting to "All."
    @Published var searchScope: SearchScopeOption = .all
    
    // Set to store any Combine cancellables (subscriptions).
    private var cancellables = Set<AnyCancellable>()
    
    // Computed property to check if the user is currently searching.
    var isSearching: Bool {
        return !searchText.isEmpty
    }
    
    // Enum to represent the different search scope options: "All" or a specific genre.
    enum SearchScopeOption: Hashable {
        case all
        case genre(option: Genre)
        
        // A computed property to return the title for each search scope option.
        var title: String {
            switch self {
            case .all:
                return "All"
            case let .genre(option):
                return option.name
            }
        }
    }
    
    // Initializer to set up subscribers.
    init() {
        addSubscribers()
    }
    
    // Function to set up subscribers to react to changes in `searchText` and `searchScope`.
    private func addSubscribers() {
        $searchText
            .combineLatest($searchScope)  // Combine changes in searchText and searchScope.
            .debounce(for: 0.3, scheduler: DispatchQueue.main)  // Delay to avoid frequent updates during typing.
            .sink(receiveValue: { [weak self] searchText, searchScope in
                // Filter movies when either searchText or searchScope changes.
                self?.filterMovies(searchText: searchText, currentSearchScope: searchScope)
            })
            .store(in: &cancellables)  // Store the subscription.
    }
    
    // Function to filter movies based on the searchText and selected search scope.
    private func filterMovies(searchText: String, currentSearchScope: SearchScopeOption) {
        // If the search text is empty, reset filteredMovies and set searchScope to "All."
        guard !searchText.isEmpty else {
            filteredMovies = []
            self.searchScope = .all
            return
        }
        
        // Start with all movies, and filter them based on the selected search scope.
        var moviesInScope = movies
        switch currentSearchScope {
        case .all:
            // No additional filtering for "All".
            break
        case let .genre(option):
            // Filter movies based on whether they contain the selected genre.
            moviesInScope = movies.filter { movie in
                movie.genres.contains(option)
            }
        }
        
        // Further filter the movies by matching the searchText in a case-insensitive manner.
        filteredMovies = moviesInScope.filter { movie in
            movie.title.lowercased().localizedCaseInsensitiveContains(searchText.lowercased())
        }
    }
    
    // Function to asynchronously fetch movies from the MoviesManager.
    func fetchMovies() async {
        do {
            // Fetch the movies asynchronously.
            let movies = try await moviesManager.fetchMovies()
            
            // Extract unique genres from the fetched movies.
            let allGenres = movies.flatMap { $0.genres }
            let uniqueGenres = Array(Set(allGenres))  // Use Set to get unique genres.
            
            // Update movies and search scopes on the main thread.
            await MainActor.run(body: {
                self.movies = movies  // Set fetched movies.
                print("Movies = \(movies)")
                
                // Print unique genres for debugging.
                print("Genres = \(uniqueGenres.map { $0.name }.joined(separator: ", "))")
                
                // Limit the displayed search scopes to the first 4 genres plus the "All" option.
                self.allSearchScopes = [.all] + uniqueGenres.map { SearchScopeOption.genre(option: $0) }.prefix(4)
            })
        } catch {
            // Handle and log errors that occur during the fetching process.
            print("error = \(error)")
        }
    }
}
