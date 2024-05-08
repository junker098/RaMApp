//
//  CharactersListReducer.swift
//  RaMApp
//
//  Created by Yuriy on 06.05.2024.
//

import Foundation
import ComposableArchitecture
import Reachability

@Reducer
struct CharactersListReducer {
    @ObservableState
    struct State: Equatable {
        var characters: [Character] = []
        var loadingStatus: LoadingStatus = .start
        var pageLimit: Int = 10
        var page: Int = 1
        var errorMessage = ""
    }
    
    enum Action {
        case loadCharacters
        case loadCharactersResponse(Result<CharacterResponse, ApiError>)
        case loadLocalResponse([Character])
        case saveCharacters
    }
    
    @Dependency(\.networkService) var networkService
    @Dependency(\.realmService) var realmService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadCharacters:
                if isInternetAvailable() {
                    guard state.loadingStatus != .loading && state.page <= state.pageLimit else { return .none }
                    state.loadingStatus = .loading
                    let next = state.page
                    DebugLogger.shared.logEvent(type: .debug, object: ("run \(next) \(state.pageLimit)"))
                    return .run { send in
                        let data = try await networkService.getAllCharacters(next)
                        await send(.loadCharactersResponse(data))
                    }
                } else {
                    state.loadingStatus = .offline
                    return .run { send in
                        let characters = try realmService.loadCharacters()
                        await send(.loadLocalResponse(characters))
                    }
                }
                
            case .loadCharactersResponse(.success(let characterResponse)):
                state.loadingStatus = .success
                state.characters += characterResponse.results
                state.pageLimit = characterResponse.info.pages
                state.page += 1
                return .none
                
            case .loadCharactersResponse(.failure(let error)):
                state.loadingStatus = .error
                state.errorMessage = error.localizedDescription
                return .none
                
            case .loadLocalResponse(let characters):
                state.characters = characters
                return .none
                
            case .saveCharacters:
                let characters = state.characters
                Task {
                    try await realmService.saveCharacters(characters)
                }
                return .none
            }
        }
    }
    
    func isInternetAvailable() -> Bool {
        do {
            let reachability = try Reachability()
            return reachability.connection != .unavailable
        } catch {
            DebugLogger.shared.logEvent(type: .error, object: error.localizedDescription)
            return false
        }
    }
}
