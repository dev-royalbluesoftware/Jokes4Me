//
//
// Jokes4MeWidget
// Jokes4MeWidget.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> JokeEntry {
        JokeEntry(date: Date(),joke: Joke.single)
    }

    func getSnapshot(in context: Context, completion: @escaping (JokeEntry) -> ()) {
        let entry = JokeEntry(date: Date(), joke: Joke.twoPart)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [JokeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = JokeEntry(date: entryDate, joke: Joke.single)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct JokeEntry: TimelineEntry {
    let date: Date
    let joke: Joke?
}

struct Jokes4MeWidgetEntryView : View {
    
    // MARK: - @Environment Property
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry

    var body: some View {
        if let joke = entry.joke {
            JokeView(joke: joke)
            
        } else {
            ContentUnavailableView {
                Text("🥲")
                    .font(.system(size: widgetFamily == .systemLarge ? 120 : 80))
            } description: {
                Text("No Joke Available")
                    .font(widgetFamily == .systemLarge ? .largeTitle : .title2)
            }
        }
    }
}

struct Jokes4MeWidget: Widget {
    let kind: String = "Jokes4MeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                Jokes4MeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
 
        }
        .configurationDisplayName("Jokes4Me")
        .description("Get a joke when you need it.")
        .supportedFamilies([.systemLarge, .systemMedium])
    }
}

#Preview("Medium Widget", as: .systemMedium) {
    Jokes4MeWidget()
} timeline: {
    JokeEntry(date: .now, joke: Joke.single)
    JokeEntry(date: .now, joke: Joke.twoPart)
}

#Preview("Large Widget", as: .systemLarge) {
    Jokes4MeWidget()
} timeline: {
    JokeEntry(date: .now, joke: Joke.single)
    JokeEntry(date: .now, joke: Joke.twoPart)
}
