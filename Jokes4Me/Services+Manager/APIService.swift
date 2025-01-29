//
//
// Jokes4Me
// APIService.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
//

import Foundation

class APIService {
    
    // MARK: - URL String Property
    
    let urlString: String
    init(urlString: String) { self.urlString = urlString }
    
    // MARK: - GetData Function
    
    func getData() async throws(APIError) -> Joke {
        guard let url = URL(string: urlString) else {
            throw .invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // valid response
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
                    
            else {
                throw APIError.invalidResponseStatus
            }
            
            // valid data
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Joke.self, from: data)
                return decodedData
                
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw .dataTaskError(error.localizedDescription)
        }
    }
}

// MARK: - APIError Enum

enum APIError: Error, LocalizedError {
    case invalidURL
    case dataTaskError(String)
    case invalidResponseStatus
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            NSLocalizedString("The endpoint URL is invalid.", comment: "")
            
        case .dataTaskError(let messageString):
            messageString
            
        case .invalidResponseStatus:
            NSLocalizedString("The API failed to issue a valid HTTP response.", comment: "")
            
        case .decodingError(let messageString):
            messageString
        }
    }
}
