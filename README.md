# Searchable Bootcamp

A SwiftUI project that demonstrates how to implement a searchable movie list with genre-based filtering using The Movie Database (TMDb) API. Users can search for movies by title and filter by genres, all while utilizing SwiftUI's `searchable` and `searchScopes` modifiers.

## Features

- **Movie Search**: Search for movies by typing in the search bar, with real-time filtering.
- **Genre-Based Filtering**: Filter movies by selecting specific genres from the available search scopes.
- **Asynchronous Data Fetching**: Uses `async/await` to fetch movie data from the TMDb API.
- **SwiftUI**: Clean and declarative user interface, including a list of movies and filter options.
- **Concurrency Safety**: Uses Swift's `actor` model to manage movie data fetching in a concurrent environment.

## Screenshots

![Simulator Screenshot - iPhone 16 Pro - 2024-10-08 at 00 11 05](https://github.com/user-attachments/assets/69c7668b-b93f-4f4b-99db-a07863251b37)

## Requirements

- iOS 15.0+ / macOS 12.0+
- Xcode 14.0+
- Swift 5.0+

## Setup

1. Clone the repository to your local machine:
    ```bash
    git clone https://github.com/khanboy1989/SearchableBootcamp.git
    ```

2. Open the project in Xcode:
    ```bash
    open SearchableBootcamp.xcodeproj
    ```

3. Replace the TMDb API key in `MoviesManager.swift` with your own API key:
    ```swift
    let apiKey = "your_tmdb_api_key_here"
    ```

4. Build and run the app on the iOS Simulator or your device.

## Usage

- **Search for Movies**: Type in the search bar to search for movies by title. Results will update in real-time as you type.
- **Filter by Genre**: Use the genre filter (search scope) to narrow down your search to specific genres (e.g., Action, Comedy, etc.).
- **See Details**: Each movie displays its title, release date, and genres in the list.

## Architecture

- **View Model**: The core of the logic is handled by `SearchableBootcampViewModel`, which manages state and filtering logic.
- **Actor for Network Calls**: The `MoviesManager` actor is responsible for safely fetching movie data from TMDb API using `URLSession`.
- **Combine**: The project uses Combine to reactively update the list when search text or genres are changed.

## Code Overview

### `SearchableBootcampViewModel.swift`

- Manages search text, filtered movie results, and search scope.
- Filters movies based on the user's input and selected genre.
- Asynchronously fetches movies from the TMDb API and updates the UI.

### `MoviesManager.swift`

- An actor that handles asynchronous movie fetching from TMDb API.
- Ensures thread-safe access to network requests.

### `SearchableBootcampView.swift`

- A SwiftUI view that displays the list of movies, search bar, and genre filtering options.
- Uses SwiftUI's `searchable` and `searchScopes` modifiers to allow dynamic searching and filtering.

## Technologies Used

- **Swift**: The primary programming language used for this project.
- **SwiftUI**: The declarative framework for building the user interface.
- **Combine**: Used to handle reactive updates to the UI based on user input.
- **URLSession**: To perform network requests and fetch data from TMDb API.
- **TMDb API**: The API that provides movie data for the app.

## API Key

To run this project, you need an API key from [TMDb](https://www.themoviedb.org/documentation/api). Follow these steps:

1. Sign up for an account at [TMDb](https://www.themoviedb.org/).
2. Navigate to your account settings and create an API key.
3. Copy the key and paste it into the `MoviesManager.swift` file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
