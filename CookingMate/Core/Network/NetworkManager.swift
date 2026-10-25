//
//  NetworkManager.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case decodingFailed
    case requestFailed(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .decodingFailed: return "Failed to decode response"
        case .requestFailed(let code): return "Request failed with code: \(code)"
        case .unknown: return "Unknown error occured"
        }
    }
}

struct LoginResponse: Decodable {
    let token: String
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func login() async throws -> String {
        let url = Enviroment.baseURL.appendingPathComponent("login")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: String] = [
            "email": "john@gmail.com",
            "password": "12345678"
        ]
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let loginResponse: LoginResponse = try handleResponse(data: data, response: response)
        
        return loginResponse.token
    }
    
    func fetch<T: Decodable>(endpoint: String) async throws -> T {
        let url = Enviroment.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let token = try await login()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return try handleResponse(data: data, response: response)
    }
    
    func post<T: Decodable, B: Encodable>(endpoint: String, body: B) async throws -> T {
        let url = Enviroment.baseURL.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let token = try await login()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        } catch {
            throw NetworkError.decodingFailed
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return try handleResponse(data: data, response: response)
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(httpResponse.statusCode)
        }
        
        // In NetworkManager.handleResponse vor dem Decoding:
          print(String(data: data, encoding: .utf8) ?? "n/a")
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding Error \(error)")
            throw NetworkError.decodingFailed
        }
    }
}
