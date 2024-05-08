//
//  RealmService.swift
//  RaMApp
//
//  Created by Yuriy on 08.05.2024.
//

import Foundation
import RealmSwift
import ComposableArchitecture

class RealmCharacter: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var type: String
    @Persisted var gender: String
    
    convenience init(character: Character) {
        self.init()
        self.id = character.id
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
    }
}

struct RealmService {
    var saveCharacters: ([Character]) async throws -> Void
    var loadCharacters: () throws -> [Character]
}

extension RealmService: DependencyKey {
    
    static var liveValue = RealmService { characters in
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                let realmCharacters = characters.map { character in
                    RealmCharacter(character: character)
                }
                realm.add(realmCharacters, update: .all)
            }
        } catch {
            throw error
        }
        
    } loadCharacters: {
        var characters: [Character] = []
        do {
            let realm = try Realm()
            let realmCharacters = realm.objects(RealmCharacter.self)
            
            realmCharacters.forEach { character in
                let newCharacter = Character(id: character.id,
                                             name: character.name,
                                             image: nil,
                                             status: character.status,
                                             species: character.species,
                                             type: character.type,
                                             gender: character.gender
                )
                characters.append(newCharacter)
            }
        } catch {
            throw error
        }
        return characters
    }
}

extension DependencyValues {
    var realmService: RealmService{
        get { self[RealmService.self] }
        set { self[RealmService.self] = newValue }
    }
}
