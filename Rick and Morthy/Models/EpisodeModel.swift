//
//  EpisodeModel.swift
//  Rick and Morthy
//
//  Created by Georgy on 22.08.2023.
//


import Foundation

// MARK: - EpisodeResponse
struct EpisodeResponse: Codable {
    let id: Int
    let name, airDate: String
    let episode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}

// MARK: - Episode
struct Episode{
    let id:Int
    let name:String
    let airDate: String
    let episode: String
}
