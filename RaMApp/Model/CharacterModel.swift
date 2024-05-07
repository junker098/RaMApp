//
//  CharacterModel.swift
//  RaMApp
//
//  Created by Yuriy on 07.05.2024.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
    let info: Info
}

struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let image: URL?
    let status: String
    let species: String
    let type: String
    let gender: String
}

struct Info: Codable, Equatable {
    let pages: Int
}

extension Character {
    static let testCharacter = Character(id: 1,
                                         name: "Toxic Rick", image: nil,
                                         status: "Dead",
                                         species: "Humanoid",
                                         type: "Rick's Toxic Side",
                                         gender: "Male"
    )
}
