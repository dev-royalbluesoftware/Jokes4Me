//
//
// Jokes4MeiOS
// InfoView.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import SwiftUI
import Charts

struct InfoView: View {
    
    // MARK: - @State Properties
    
    @State private var info: Info?
    @State private var errorString = ""
    @State private var fetching = false
    @State private var chartItems: [ChartItem] = []
    
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
                            Chart {
                                ForEach(chartItems) { item in
                                    BarMark(x: .value("Language", item.lang), y: .value("Total", item.qty))
                                        .position(by: .value("Type", item.jokeType.rawValue))
                                        .foregroundStyle(by: .value("Type", item.jokeType.rawValue))
                                        .annotation(position: .top, alignment: .center) {
                                            Text("\(item.qty)")
                                                .font(.caption)
                                        }
                                }
                            }
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
                buildChartInfo()
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
    
    // MARK: - Build Chart Info Function
    
    func buildChartInfo() {
        var chartItems: [ChartItem] = []
        
        if let info {
            for safeItem in info.jokes.safeJokes {
                let langName = Language(rawValue: safeItem.lang)!.full
                let safeChartItem = ChartItem(lang: langName, qty: safeItem.count, jokeType: .safe)
                chartItems.append(safeChartItem)
                
                // unsafe chart items
                let langTotal = info.jokes.langCount[safeItem.lang] ?? 0
                let unsafeCount = langTotal - safeItem.count
                let unsafeChartItem = ChartItem(lang: langName, qty: unsafeCount, jokeType: .unsafe)
                chartItems.append(unsafeChartItem)
            }
            self.chartItems = chartItems
        }
    }
}

#Preview {
    InfoView()
}
