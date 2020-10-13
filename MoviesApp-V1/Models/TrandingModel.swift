//
//  TrandingModel.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/12/20.
//

import Foundation

// MARK: - Tranding
struct TrandingModel: Codable {
    let results: [TrandingResult]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct TrandingResult: Codable {
    let originalName: String?
    let id: Int
    let name: String?
    let voteCount: Int
    let voteAverage: Double
    let firstAirDate: String?
    let posterPath: String
    let genreIDS: [Int]
    let originalLanguage: OriginalLanguage
    let backdropPath, overview: String
    let originCountry: [String]?
    let popularity: Double
    let mediaType: MediaType
    let video: Bool?
    let title, releaseDate, originalTitle: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case id, name
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case overview
        case originCountry = "origin_country"
        case popularity
        case mediaType = "media_type"
        case video, title
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case adult
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
}
