//
//  ContentView.swift
//  CookingMate
//
//  Created by Johann Schneider on 21.08.26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = RecipeViewModel()
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                LibraryView()
            }
            .tabItem {
                Label("Library", systemImage: "book")
            }
        }
    }
}

#Preview {
    // Log to verify the resolved baseURL in previews without crashing
    print("BaseURL:", Enviroment.baseURL)
    return ContentView()
}
