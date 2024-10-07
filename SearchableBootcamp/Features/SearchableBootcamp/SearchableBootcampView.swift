//
//  SearchableBootcampView.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import SwiftUI

struct SearchableBootcampView: View {
    
    @StateObject var viewModel = SearchableBootcampViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text("Release Date: \(movie.release_date)")
                    
                }
            }.navigationTitle("Movies")
            .task {
                await viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    SearchableBootcampView()
}
