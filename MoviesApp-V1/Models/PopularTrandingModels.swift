//
//  PopularMoviesModel.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/9/20.
//

import Foundation
import UIKit

// MARK: - Result
struct PopularTrandingModels: Codable {
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let popularity: Double? //yes
    let voteCount: Int? //yes
    let posterPath: String? //yes
    let id: Int? //yes
    let backdropPath: String? //yes
    let genreIDS: [Int]? //yes
    let title: String? //no so I have to add name
    let name: String?
    let originalName: String?
    let originalTitle: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    let firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case title
        case name
        case originalName = "original_name"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
    }
}
