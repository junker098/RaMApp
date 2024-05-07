//
//  CharacterDetailView.swift
//  RaMApp
//
//  Created by Yuriy on 07.05.2024.
//

import SwiftUI
import NukeUI

struct CharacterDetailView: View {
    
    var character: Character
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(
                    LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                )
                .frame(maxWidth: .infinity, maxHeight: 250)
            
            VStack {
                LazyImage(url: character.image) { state in
                    if let image = state.image {
                        image
                            .resizable()
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                    }
                }
                .modifier(ProfileImageModifier())
                VStack(alignment: .leading) {
                    HStack {
                        Text("Name: ")
                            .fontWeight(.medium)
                            .foregroundStyle(.green)
                        Text(character.name)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
                    .font(.title)
                    Divider()
                    HStack {
                        Text("Status: ")
                        Text(character.status)
                            .foregroundStyle(.black)
                    }
                    Divider()
                    HStack {
                        Text("Species: ")
                        Text(character.species)
                            .foregroundStyle(.black)
                    }
                    Divider()
                    HStack {
                        Text("Type: ")
                        Text(character.type.isEmpty ? "---" : character.type)
                            .foregroundStyle(.black)
                    }
                    Divider()
                    HStack {
                        Text("Gender: ")
                        Text(character.gender)
                            .foregroundStyle(.black)
                    }
                }
                .font(.title2)
                .foregroundStyle(.blue)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding()
                
            }
            .offset(y: -110)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterDetailView(character: Character.testCharacter)
}
