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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await viewModel.fetchMovies()
            }
    }
}

#Preview {
    SearchableBootcampView()
}
