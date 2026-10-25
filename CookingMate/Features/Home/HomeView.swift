//
//  HomeView.swift
//  CookingMate
//
//  Created by Johann Schneider on 04.09.26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Deine zuletzt benutzten Rezepte")
                .font(.headline)
            
            Divider()
            
            RecipeLookUpListView()
            
            Spacer()
            
            HStack {
                Spacer()
                NavigationLink(destination: RecipeAddingView()) {
                    Circle()
                        .frame(width: 60)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 4)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundStyle(Color.red)
                                .fontWeight(.heavy)
                        )
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 10)
        .padding(.leading, 10)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
