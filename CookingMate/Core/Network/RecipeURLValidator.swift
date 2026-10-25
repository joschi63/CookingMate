import Foundation

enum RecipeURLValidator {
    /// Trims whitespace and assumes HTTPS when the user enters a bare domain.
    static func completeURL(from input: String) -> URL? {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else { return nil }

        let normalizedInput: String
        if trimmedInput.hasPrefix("http://") || trimmedInput.hasPrefix("https://") {
            normalizedInput = trimmedInput
        } else {
            normalizedInput = "https://\(trimmedInput)"
        }

        guard
            let components = URLComponents(string: normalizedInput),
            let scheme = components.scheme?.lowercased(),
            ["http", "https"].contains(scheme),
            let host = components.host,
            host.contains(".")
        else {
            return nil
        }

        return components.url
    }

    static func isReachable(_ url: URL) async -> Bool {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.timeoutInterval = 10

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return false }
            return (200...399).contains(response.statusCode)
        } catch {
            return false
        }
    }
}
