//
//
// Jokes4MeiOS
// InfoView.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import SwiftUI

struct InfoView: View {
    
    // MARK: - @State Properties
    
    @State private var info: Info?
    @State private var errorString = ""
    @State private var fetching = false
    
    // MARK: - Properties
    
    let jokeManager = JokeManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if fetching {
                    ProgressView()
                    
                } else {
                    if let info {
                        VStack {
                            Text("Total # of Jokes: \(info.jokes.totalCount)")
                                .font(.largeTitle)
                             
                            // Bar Chart
                        }
                        .padding()

                    } else {
                        Text(errorString)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Joke Distribution")
            .task {
                await getInfo()
            }
        }
    }
    
    // MARK: - Get Info Function
    
    func getInfo() async {
        errorString = ""
        fetching.toggle()
        
        defer {
            fetching.toggle()
        }
        
        do {
            let info = try await jokeManager.getInfo()
            withAnimation {
                self.info = info
            }
            
        } catch {
            errorString = error.localizedDescription
        }
    }
}

#Preview {
    InfoView()
}
