//
//
// Jokes4MeiOS
// TranslationView.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
//


import SwiftUI
import Translation

struct TranslationView: View {
    
    // MARK: - @State Properties
    
    @State private var translationService = TranslationService()
    @State private var targetLanguage = Locale.Language(languageCode: "en", script: nil, region: "US")
    @State private var configuration: TranslationSession.Configuration?
    
    // MARK: - Properties
    
    let joke: Joke
    
    var body: some View {
        Text(translationService.translatedText)
            .italic()
            .textSelection(.enabled)
            .translationTask(configuration) { session in
                do {
                    try await translationService.translate(text: joke.fullJoke, session: session)
                    
                } catch {
                    translationService.translatedText = ""
                }
            }
        
        Picker("Target Language", selection: $targetLanguage) {
            ForEach(translationService.availableLanguages) { language in
                Text(language.localizedName()).tag(language.locale)
            }
        }
        .onChange(of: targetLanguage) { oldValue, newValue in
            if newValue != oldValue {
                configuration?.invalidate()
                configuration = TranslationSession.Configuration(target: targetLanguage)
            }
        }
        .onChange(of: joke) {
            translationService.translatedText = ""
        }
        
        if let langCode = targetLanguage.languageCode, "\(langCode)" != joke.lang.rawValue, translationService.translatedText.isEmpty {
            HStack {
                Button("Translate", systemImage: "translate") {
                    triggerTranslation()
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.white)
                .disabled(joke.fullJoke.isEmpty)
                
                Spacer()
            }
        }
    }
    
    // MARK: - Trigger Translation Function
    
    func triggerTranslation() {
        if configuration == nil {
            configuration = TranslationSession.Configuration(target: targetLanguage)
            
        } else {
            configuration?.invalidate()
        }
    }
}

#Preview {
    TranslationView(joke: Joke.single)
}
