//
//  userInfo.swift
//  marble
//
//  Created by Timothy Hu on 1/19/24.
//

import SwiftUI


func getUser() async throws -> User {
    let endpoint = "https://api.github.com/users/sallen0400"
    
    guard let url = URL(string: endpoint) else { throw UserError.invalidURL }
            
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw UserError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(User.self, from: data)
    }
    catch {
        throw UserError.invalidData
    }
}
