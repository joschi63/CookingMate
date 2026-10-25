//
//  RecipeLookUpViewModel.swift
//  CookingMate
//
//  Created by Johann Schneider on 13.09.26.
//

import Foundation

@Observable
@MainActor
class RecipeLookUpViewModel {
    var recipes: [RecipeLookUp]?
    var errorMessage: String?
    
    func getRecipeLookUps() async {
        do {
            
            let responses: [RecipeLookUpDTO] = try await NetworkManager.shared.fetch(
                endpoint: "/recipes/lookup"
            )
            
            recipes = responses.map { RecipeLookUp(dto: $0) }
        } catch {
            errorMessage = error.localizedDescription
            print("Error occurred: \(error.localizedDescription)")
        }
    }
}
