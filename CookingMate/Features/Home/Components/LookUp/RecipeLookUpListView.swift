//
//  RecipeLookUpListView.swift
//  CookingMate
//
//  Created by Johann Schneider on 13.09.26.
//

import SwiftUI

struct RecipeLookUpListView: View {
    @State var viewModel: RecipeLookUpViewModel = RecipeLookUpViewModel()
    
    var body: some View {
        if viewModel.recipes != nil {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.recipes!, id: \.id) { recipe in
                        NavigationLink(value: recipe.id) {
                            RecipeLookUpView(recipe: recipe)
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .navigationDestination(for: UUID.self) { recipeID in
                RecipeView(recipeID: recipeID)
            }
        } else {
            ProgressView()
                .task {
                    await viewModel.getRecipeLookUps()
                }
                .navigationTitle("Recipe")
        }
        
    }
}

#Preview {
    RecipeLookUpListView()
}
