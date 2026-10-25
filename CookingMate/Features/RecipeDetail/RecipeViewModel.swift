//
//  RecipeViewModel.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

@Observable
@MainActor
class RecipeViewModel {
    var recipe: Recipe?
    
    var ingredients: [Ingredient] {
        get { recipe?.ingredients ?? [] }
        set { recipe?.ingredients = newValue }
    }
    
    var steps: [Step] {
        get { recipe?.steps ?? [] }
        set { recipe?.steps = newValue }
    }
    
    func getRecipe(from id: UUID) async {
        do {
            
            let response: RecipeDTO = try await NetworkManager.shared.fetch(
                endpoint: "/recipes/global/\(id.uuidString)"
            )
            self.recipe = Recipe(dto: response)
        }
        catch {
            print("error occured: \(error.localizedDescription)")
        }
    }
}
