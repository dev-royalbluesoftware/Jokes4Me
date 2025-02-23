//
//
// Jokes4MeWidgetExtension
// JokeView.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import SwiftUI

struct JokeView: View {
    
    // MARK: - Properties
    
    let joke: Joke
    
    var body: some View {
        HStack {
            Text(joke.category.emoji)
                .font(.system(size: 60))
            
            Text(joke.fullJoke)
                .font(.largeTitle)
                .lineLimit(nil)
                .minimumScaleFactor(0.2)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
