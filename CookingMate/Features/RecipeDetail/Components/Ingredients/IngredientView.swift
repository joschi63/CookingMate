//
//  IngredientView.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import SwiftUI

struct IngredientView: View {
    
    @Binding var ingredient: Ingredient
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if ingredient.amount > 0 {
                Text("\(ingredient.amount, format: .number.precision(.fractionLength(0...1))) \(ingredient.unit)")
                    .fontWeight(.semibold)
                    .frame(width: 100, alignment: .leading)
            }
            
            Text(ingredient.name)
                .foregroundColor(.primary)
            
            Spacer()
            
            if ingredient.animalProd {
                Button {
                    
                } label: {
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(.green)
                }
            }
        }
    }
}

#Preview {
    let ingredient = Ingredient(id: UUID(), name: "Onions", amount: 2.0, unit: "pieces", replacementProd: nil, animalProd: false)
    IngredientView(ingredient: .constant(ingredient))
}
