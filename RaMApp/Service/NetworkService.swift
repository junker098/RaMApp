//
//  NetworkService.swift
//  RaMApp
//
//  Created by Yuriy on 07.05.2024.
//

import Foundation
import ComposableArchitecture

enum PathList {
    static let baseUrl = "https://rickandmortyapi.com/api/character/"
}

enum LoadingStatus {
    case start
    case loading
    case success
    case error
    case offline
}

enum ApiError: Error {
    case requestError(String)
    case invalidUrl(String)
}

struct NetworkService {
    var getAllCharacters: (Int) async throws -> Result<CharacterResponse, ApiError>
}

extension NetworkService: DependencyKey {
    
    static var liveValue = NetworkService { page in
        guard let url = URL(string: "\(PathList.baseUrl)?page=\(page)") else {
            return .failure(.invalidUrl("Invalid URL"))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let characters = try JSONDecoder().decode(CharacterResponse.self, from: data)
            return .success(characters)
        } catch {
            return .failure(.requestError(error.localizedDescription))
        }
    }
}

extension DependencyValues {
    var networkService: NetworkService{
        get { self[NetworkService.self] }
        set { self[NetworkService.self] = newValue }
    }
}
