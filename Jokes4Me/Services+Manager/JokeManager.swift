//
//
// Jokes4Me
// JokeManager.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
//

import Foundation
import OSLog

class JokeManager {
    
    // MARK: - Properties
    
    let logger = Logger(subsystem: "Jokes4Me.Service", category: "JokeManager")
    let issueURL = "https://github.com/Sv443-Network/JokeAPI/issues/new?assignees=Sv443&labels=joke+edit&projects=&template=3_edit_a_joke.md&title="
    
    // MARK: - Get Info Function
    
    func getInfo() async throws -> Info {
        let url = "https://v2.jokeapi.dev/info"
        let apiService = APIService(urlString: url)
        
        do {
            return try await apiService.getData()
            
        } catch {
            throw error
        }
    }
    
    // MARK: - Get Joke Function
    
    func getJoke(category: Category = .Any, language: Language = .en) async throws -> Joke {
        let urlString = "https://v2.jokeapi.dev/joke/\(category)?lang=\(language)&blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
                     // "https://v2.jokeapi.dev/joke/\(category)?lang=\(language)&blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
        logger.info("\(urlString)")
        
        let apiService = APIService(urlString: urlString)
        do {
            return try await apiService.getData()
            
        } catch {
            throw error
        }
    }
}
