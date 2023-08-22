//
//  PlanetModel.swift
//  Rick and Morthy
//
//  Created by Georgy on 22.08.2023.
//

import Foundation
// MARK: - PlanetResponse
struct PlanetResponse: Codable {
    let id: Int
    let name, type: String
}

// MARK: - Planet
struct Planet{
    let id: Int
    let name: String
    let type: String
}

