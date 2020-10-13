//
//  PopularTVModel.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/12/20.
//

import Foundation
import UIKit


// MARK: - PopularTV
struct PopularTV: Codable {
    let results: [TVResult]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct TVResult: Codable {
    let originalName: String
    let genreIDS: [Int]
    let name: String
    let popularity: Double
    //let originCountry: [OriginCountry]
    let voteCount: Int
    let firstAirDate, backdropPath: String
    //let originalLanguage: OriginalLanguage
    let id: Int
    let voteAverage: Double
    let overview, posterPath: String

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        //case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        //case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

//enum OriginCountry: String, Codable {
//    case es = "ES"
//    case us = "US"
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case es = "es"
//}

