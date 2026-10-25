import Foundation
import Observation

struct GetRecipe: Encodable {
    let url: String
}

private struct SaveRecipeResponse: Decodable {
    let message: String
}

enum RecipeAddingError: LocalizedError {
    case invalidURL
    case unreachableURL
    case importFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Bitte überprüfe die URL."
        case .unreachableURL:
            return "Die Website ist nicht erreichbar. Gib eine andere URL ein."
        case .importFailed:
            return "Das Rezept konnte nicht geladen werden."
        }
    }
}

@Observable
@MainActor
final class RecipeAddingViewModel {
    var recipe: Recipe?
    var hasRecipe: Bool {
        recipe != nil
    }
    
    var ingredients: [Ingredient] {
        get { recipe?.ingredients ?? [] }
        set { recipe?.ingredients = newValue }
    }
    
    var steps: [Step] {
        get { recipe?.steps ?? [] }
        set { recipe?.steps = newValue }
    }

    var isSubmitting: Bool = false
    var recipeURL: String = "https://www.bremer-gewuerzhandel.de/rezepte/gruene-bohnen-mit-speck-und-zwiebeln"
    
    var errorMessage: String? = nil
    
    
    func getNewRecipe(from input: String) async throws -> Recipe {
        guard let url = RecipeURLValidator.completeURL(from: input) else {
                throw RecipeAddingError.invalidURL
            }

            guard await RecipeURLValidator.isReachable(url) else {
                throw RecipeAddingError.unreachableURL
            }

            do {
                let response: RecipeDTO = try await NetworkManager.shared.post(
                    endpoint: "/newrecipe/",
                    body: GetRecipe(url: url.absoluteString)
                )
                return Recipe(dto: response)
            } catch {
                throw RecipeAddingError.importFailed
            }
    }
    
    func submitURL() async {
        isSubmitting = true
        defer { isSubmitting = false }
        
        async let minimumDelay: Void = try! Task.sleep(for: .seconds(2))
        
        do {
            let recipe = try await getNewRecipe(from: recipeURL)
            _ = await minimumDelay
            
            self.recipe = recipe
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func saveRecipe() async -> Bool {
        guard let recipe else { return false }
        
        isSubmitting = true
        defer { isSubmitting = false }
        
        async let minimumDelay: Void = try! Task.sleep(for: .seconds(2))
        
        do {
            let _: SaveRecipeResponse = try await NetworkManager.shared.post(
                endpoint: "/newrecipe/save/\(recipe.id.uuidString)")
            
            _ = await minimumDelay
            
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
