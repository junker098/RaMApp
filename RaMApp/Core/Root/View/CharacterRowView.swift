//
//  CharacterRowView.swift
//  RaMApp
//
//  Created by Yuriy on 07.05.2024.
//

import SwiftUI
import NukeUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
    
        HStack(content: {
            LazyImage(url: character.image) { state in
                if let image = state.image {
                    image.resizable()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Name: \(character.name)")
                Text("Status: \(character.status)")
            }
            
            Spacer()
        })
    }
}

#Preview {
    CharacterRowView(character: Character.testCharacter)
}
