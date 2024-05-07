//
//  ProfileImageModifier.swift
//  RaMApp
//
//  Created by Yuriy on 07.05.2024.
//

import SwiftUI

struct ProfileImageModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.green, lineWidth: 3)
            }
            .shadow(color: Color.yellow.opacity(0.8), radius: 1, x: 0, y: 2)
    }
}
