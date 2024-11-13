//
//  SearchableBootcampApp.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

import SwiftUI

@main
struct SearchableBootcampApp: App {
    var body: some Scene {
        WindowGroup {
            SearchableBootcampView()
        }
    }
}

struct MoviesManagerKey: EnvironmentKey {
    static let defaultValue: MoviesManager = MoviesManager()
}

extension EnvironmentValues {
    var moviesManager: MoviesManager {
        get { self[MoviesManagerKey.self] }
        set { self[MoviesManagerKey.self] = newValue }
    }
}
