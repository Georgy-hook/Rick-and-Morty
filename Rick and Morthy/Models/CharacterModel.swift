//
//  CharacterModel.swift
//  Rick and Morthy
//
//  Created by Georgy on 19.08.2023.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: CharacterResult
}

struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

// MARK: - Character
struct CharacterResultElement: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

typealias CharacterResult = [CharacterResultElement]

// MARK: - Character struct

struct Character {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
