//
//  HTTPService.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation

protocol FoodAPI {
    func fetchFood() async throws -> MexicanFood
}

class HTTPService {
    
    static let shared: HTTPService = .init()
    private init() {}
}

extension HTTPService: FoodAPI {
    func fetchFood() async throws -> MexicanFood {
        guard let url = URL(string: "https://the-mexican-food-db.p.rapidapi.com/") else {
            return []
        }
        let headers = [
            "X-RapidAPI-Key": "a8f4bf4e89mshc8338297d035ef9p16676bjsn114233b9387b",
            "X-RapidAPI-Host": "the-mexican-food-db.p.rapidapi.com"
        ]
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(MexicanFood.self, from: data)
        return result
    }
}
