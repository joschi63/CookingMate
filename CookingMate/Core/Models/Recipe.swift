//
//  Recipe.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

struct RecipeDTO: Decodable {
    let recipeData: RecipeDataDTO
    let ingredients: [IngredientDTO]
    let steps: [StepDTO]

    enum CodingKeys: String, CodingKey {
        case recipeData = "recipe_data"
        case ingredients
        case steps
    }
}

struct Recipe: Identifiable {
    let id: UUID
    var recipeData: RecipeData
    var ingredients: [Ingredient]
    var steps: [Step]

    init(
        id: UUID,
        recipeData: RecipeData,
        ingredients: [Ingredient],
        steps: [Step]
    ) {
        self.id = id
        self.recipeData = recipeData
        self.ingredients = ingredients
        self.steps = steps
    }

    init(dto: RecipeDTO) {
        self.init(
            id: dto.recipeData.id,
            recipeData: RecipeData(dto: dto.recipeData),
            ingredients: dto.ingredients.map { Ingredient(dto: $0) },
            steps: dto.steps.map { Step(dto: $0) }
        )
    }
}

extension UUID {
    static let placeholderServerID = UUID(
        uuidString: "00000000-0000-0000-0000-000000000000"
    )!

    var normalizedServerID: UUID? {
        self == .placeholderServerID ? nil : self
    }
}
