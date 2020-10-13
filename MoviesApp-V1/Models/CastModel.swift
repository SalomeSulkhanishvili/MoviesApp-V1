//
//  CastModel.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/12/20.
//

import Foundation

// MARK: - Cast
struct Cast: Codable {
    let id: Int
    let cast: [CastElement]
    let crew: [Crew]
}

// MARK: - CastElement
struct CastElement: Codable {
    let castID: Int? //is not in tv
    let character, creditID: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

// MARK: - Crew
struct Crew: Codable {
    let creditID : String
    let gender, id: Int
    let job, name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case gender, id, job, name
        case profilePath = "profile_path"
    }
}
