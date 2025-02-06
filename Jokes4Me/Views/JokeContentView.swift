//
//
// Jokes4Me
// JokeContentView.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
//


import SwiftUI

struct JokeContentView: View {
    
    // MARK: - Properties
    
    let jokeManager = JokeManager()
    
    // MARK: - State Properties
    
    @State private var joke: Joke?
    @State private var category: Category = .Any
    @State private var language: Language = .en
    @State private var errorString = ""
    @State private var fetchingJoke = false
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationStack {
            ZStack {
                if fetchingJoke {
                    ProgressView()
                }
                ScrollView {
                    // VStack - HStack/Refresh Button
                    VStack {
                        // HStack - Language Picker/Category Picker
                        HStack {
                            Picker("Language", selection: $language) {
                                ForEach(Language.allCases) { language in
                                    Text(language.full)
                                }
                            }
                            Picker("Category", selection: $category) {
                                ForEach(Category.allCases) { category in
                                    Text("\(category)")
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button {
                            Task {
                                await getJoke()
                            }
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        // JokeView
                        JokeView(joke: joke, errorString: errorString)
                        
                        // HStack - Spacer/Sharelink
                        HStack {
                            Spacer()
                            
                            if let joke {
                                ShareLink(item: joke.fullJoke)
                            }
                        }
                        
                        // HStack - Report Joke Button/Unsafe Joke Text
#if os(iOS)
                        if let joke {
                            TranslationView(joke: joke)
                        }
#endif
                        HStack(alignment: .top) {
                            if let joke {
                                Button("Report Joke", role: .destructive) {
                                    let jokeToReport = "\(joke.id)\n\(joke.fullJoke)"
                                    
#if os(macOS)
                                    let pasteboard = NSPasteboard.general
                                    pasteboard.declareTypes([.string], owner: nil)
                                    pasteboard.setString(jokeToReport, forType: .string)
                                    
#else
                                    let pasteboard = UIPasteboard.general
                                    pasteboard.string = jokeToReport
#endif
                                    
                                    guard let url = URL(string: jokeManager.issueURL) else { return }
                                    openURL(url)
                                }
                                .buttonStyle(.bordered)
                                
                                Text("You can report an unsafe joke.  The Joke id and content will be on your clipboard.")
                                    .font(.caption)
                                    .lineLimit(nil)
                                    .foregroundStyle(.red)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
            }
            .navigationTitle("Jokes4Me")
        }
        .task {
            await getJoke()
        }
        .task(id: category) {
            await getJoke()
        }
        .task(id: language) {
            await getJoke()
        }
    }
    
    // MARK: - Get Joke Function
    
    func getJoke() async {
        errorString = ""
        fetchingJoke = true
        defer {
            fetchingJoke = false
        }
        
        do {
            let joke = try await jokeManager.getJoke(category: category, language: language)
            withAnimation {
                self.joke = joke
            }
            
        } catch {
            errorString = "No joke for \(category) - \(language)"
        }
    }
}

#Preview {
    JokeContentView()
}
