//
//  IngredientListView.swift
//  CookingMate
//
//  Created by Johann Schneider on 29.08.26.
//

import SwiftUI

struct IngredientListView: View {
    @Binding var ingredients: [Ingredient]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Zutaten")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                
                Divider()
            }
            
            ForEach($ingredients) { $ingr in
                VStack(alignment: .leading) {
                    IngredientView(ingredient: $ingr)
                    Divider()
                        .padding(.vertical, 0)
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    let  mockIngredients = [Ingredient(id: UUID(), name: "Zwiebeln", amount: 2.0, unit: "Stück", replacementProd: nil, animalProd: false)]
    
    IngredientListView(ingredients: .constant(mockIngredients))
}
