//
//  RecipeLookUpView.swift
//  CookingMate
//
//  Created by Johann Schneider on 13.09.26.
//

import SwiftUI

struct RecipeLookUpView: View {
    
    let recipe: RecipeLookUp
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer()

            Text(recipe.name)
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .frame(width: 250, height: 160)
        .background(
            RoundedRectangle(cornerRadius: 10, style: RoundedCornerStyle.continuous)
                .fill(Color(red: 0.98, green: 0.95, blue: 0.88))
                .overlay(alignment: .topLeading) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color(red: 0.58, green: 0.34, blue: 0.20))
                        .frame(width: 38, height: 38)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.75))
                        )
                        .padding(14)
                }
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    let mockRecipeLookUp = RecipeLookUp(id: UUID(), name: "Brezeln bayrischer Art")
    RecipeLookUpView(recipe: mockRecipeLookUp)
}
