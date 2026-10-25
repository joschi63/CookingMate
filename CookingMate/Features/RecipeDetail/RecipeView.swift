//
//  RecipeView.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import SwiftUI

struct RecipeView: View {
    
    @State var recipeID: UUID
    @State private var viewModel = RecipeViewModel()
    
    var body: some View {
        if viewModel.recipe != nil {
            List {
                Section {
                    RecipeDataView(recipeData: viewModel.recipe!.recipeData)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 5))
                .listRowBackground(Color.clear)
                
                Section {
                    IngredientListView(ingredients: $viewModel.ingredients)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 5))
                .listRowBackground(Color.clear)
                
                Section {
                    StepListView(steps: $viewModel.steps)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 5))
                .listRowBackground(Color.clear)
            }
            .navigationTitle(viewModel.recipe!.recipeData.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding(15)
            
        } else {
            ProgressView()
                .task {
                    await viewModel.getRecipe(from: recipeID)
                }
                .navigationTitle("Recipe")
        }
    }
}

#Preview {
    RecipeView(recipeID: UUID(uuidString: "96961898-4e9f-422d-b392-5955a4d88d32")!)
}
