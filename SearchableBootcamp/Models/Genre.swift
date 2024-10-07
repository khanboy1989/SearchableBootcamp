//
//  Genre.swift
//  SearchableBootcamp
//
//  Created by Serhan Khan on 07/10/2024.
//

enum Genre: Int, CaseIterable, Codable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    case unknown

    var name: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .animation: return "Animation"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .documentary: return "Documentary"
        case .drama: return "Drama"
        case .family: return "Family"
        case .fantasy: return "Fantasy"
        case .history: return "History"
        case .horror: return "Horror"
        case .music: return "Music"
        case .mystery: return "Mystery"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .tvMovie: return "TV Movie"
        case .thriller: return "Thriller"
        case .war: return "War"
        case .western: return "Western"
        case .unknown: return "Unknown"
        }
    }
    
    init(rawValue: Int) {
        switch rawValue {
        case 28: self = .action
        case 12: self = .adventure
        case 16: self = .animation
        case 35: self = .comedy
        case 80: self = .crime
        case 99: self = .documentary
        case 18: self = .drama
        case 10751: self = .family
        case 14: self = .fantasy
        case 36: self = .history
        case 27: self = .horror
        case 10402: self = .music
        case 9648: self = .mystery
        case 10749: self = .romance
        case 878: self = .scienceFiction
        case 10770: self = .tvMovie
        case 53: self = .thriller
        case 10752: self = .war
        case 37: self = .western
        default: self = .unknown
        }
    }
}
