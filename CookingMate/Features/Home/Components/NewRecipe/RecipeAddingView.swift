//
//  RecipeAddingView.swift
//  CookingMate
//
//  Created by Johann Schneider on 23.10.26.
//

import SwiftUI

struct RecipeAddingView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel = RecipeAddingViewModel()
    
    @State private var urlInputFocused = false
    
    var body: some View {
        ZStack {
            if !viewModel.hasRecipe {
                VStack {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Divider()
                        
                        Text("Rezept-URL")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            TextField("https://...", text: $viewModel.recipeURL)
                                .textFieldStyle(
                                    .roundedBorder
                                )
                                .keyboardType(.URL)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .submitLabel(.go)
                                .onSubmit { Task { await viewModel.submitURL() } }
                        }
                        
                        Button {
                            Task { await viewModel.submitURL() }
                        } label: {
                            if viewModel.isSubmitting {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("URL prüfen")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isSubmitting || viewModel.recipeURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    
                    Spacer()
                }
                .transition(.scale(scale: 0.92).combined(with: .opacity))
                
            } else if let recipe = viewModel.recipe {
                List {
                    Section {
                        RecipeDataView(recipeData: recipe.recipeData, isAddingView: true)
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
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                
            } else {
                Text("Something went wrong. Please try again!")
                    .font(.headline)
                    .foregroundStyle(.red)
            }
        }
        .padding(20)
        .animation(.spring(response: 1.0, dampingFraction: 0.85), value: viewModel.hasRecipe)
        
        .navigationTitle("Neues Rezept")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("Speichern")
                        .font(.headline)
                        .foregroundStyle(viewModel.hasRecipe ? Color.green : Color.gray)
                        
                }
                .disabled(!viewModel.hasRecipe)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeAddingView()
    }
}
