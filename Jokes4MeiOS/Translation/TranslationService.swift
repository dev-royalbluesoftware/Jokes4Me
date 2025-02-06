//
//
// Jokes4MeiOS
// TranslationService.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import Foundation
import Translation

@Observable
class TranslationService {
    
    var translatedText = ""
    var availableLanguages: [AvailableLanguage] = []
    
    init() { getAvailableLanguages() }
    
    func getAvailableLanguages() {
        Task { @MainActor in
            let supportedLanguages = await LanguageAvailability().supportedLanguages
            availableLanguages = supportedLanguages.map({ local in
                AvailableLanguage(locale: local)
            }).sorted()
        }
    }
    
    func translate(text: String, session: TranslationSession) async throws {
        let response = try await session.translate(text)
        translatedText = response.targetText
    }
}
