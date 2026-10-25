//
//  RecipeDataView.swift
//  CookingMate
//
//  Created by Johann Schneider on 04.09.26.
//

import SwiftUI

struct RecipeDataView: View {
    
    @State var recipeData: RecipeData
    @State var isAddingView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(recipeData.name)
                    .font(Font.system(size: 25, weight: .bold, design: .default))
                
                Spacer()
                
                Text(recipeData.author)
            }
            
            Divider()
            
            Text(recipeData.sourceURL)
                .padding(.vertical, 5)
            
            
            if !isAddingView {
                
                Divider()
                
                HStack {
                    Text("Portionen")
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Circle()
                            .frame(width: 25)
                            .foregroundStyle(.cyan)
                            .overlay(Image(systemName: "minus").foregroundStyle(.black).fontWeight(.heavy))
                    }
                    
                    Text(recipeData.portions, format:
                            .number.precision(.fractionLength(0...1)))
                    
                    Button {
                        
                    } label: {
                        Circle()
                            .frame(width: 25)
                            .foregroundStyle(.cyan)
                            .overlay(Image(systemName: "plus").foregroundStyle(.black).fontWeight(.heavy))
                    }
                }
                .padding(.vertical, 5)
            }
            
            Divider()
        }
            
    }
}


#Preview {
    let mockRecipeData = RecipeData(name: "Pfannkuchen", author: "Oma", portions: 2, sourceURL: "https://omas-rezepte.de/pfannkuchen")
    
    RecipeDataView(recipeData: mockRecipeData)
}
