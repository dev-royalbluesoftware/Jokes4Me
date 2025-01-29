//
//
// Jokes4Me
// Joke.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import Foundation

struct Joke: Codable, Equatable {
    let id: Int
    let category: Category
    let type: JokeType
    let lang: Language
    let setup: String?
    let delivery: String?
    let joke: String?
    
    var fullJoke: String {
        switch type {
        case .twoPart:
            (setup ?? "") + "\n\n" + (delivery ?? "")

        case .single:
             joke ?? ""
        }
    }
    
    static let single = Joke(id: 1, category: .Misc, type: .single, lang: .en, setup: nil, delivery: nil, joke: "Never date a baker they are too kneady.")
    static let twoPart = Joke(id: 2, category: .Pun, type: .twoPart, lang: .en, setup: "What do you call a cow with no legs?", delivery: "GROUND BEEF!", joke: nil)
    
}
