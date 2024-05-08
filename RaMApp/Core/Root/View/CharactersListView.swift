//
//  CharactersListView.swift
//  RaMApp
//
//  Created by Yuriy on 06.05.2024.
//

import SwiftUI
import ComposableArchitecture

struct CharactersListView: View {
    
    let store: StoreOf<CharactersListReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            WithPerceptionTracking {
                NavigationView {
                    List {
                        ForEach(store.characters, id: \.id) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                CharacterRowView(character: character)
                                    .onAppear {
                                        //pagination
                                        if character == viewStore.characters.last  {
                                            viewStore.send(.loadCharacters)
                                        }
                                    }
                            }
                        }
                        if viewStore.loadingStatus == .loading || viewStore.loadingStatus == .start  {
                            ProgressView()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .navigationTitle("Rick and Morty")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                viewStore.send(.saveCharacters)
                            } label: {
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.black)
                            }
                            .disabled(viewStore.loadingStatus == .offline)
                        }
                    }
                }
                .tint(.black)
                .alert(isPresented: .constant(viewStore.loadingStatus == .error)) {
                    Alert(title: Text("Error"), message: Text(viewStore.errorMessage), dismissButton: .default(Text("Close")))
                }
            }
            .onAppear {
                viewStore.send(.loadCharacters)
            }
        }
    }
}

#Preview {
    CharactersListView(store: Store(initialState: CharactersListReducer.State(), reducer: {
        CharactersListReducer()
    }))
}
