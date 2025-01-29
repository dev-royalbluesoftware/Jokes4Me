//
//
// Jokes4Me
// Category.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


enum Category: String, Codable, CaseIterable, Identifiable {
    case `Any`
    case Programming
    case Misc
    case Dark
    case Pun
    case Spooky
    case Christmas
    var id: Self { self }
    
    var emoji: String {
        switch self {
        case .Any:
            ""
        case .Programming:
            "🤖"
        case .Misc:
           "🎉"
        case .Dark:
            "🌙"
        case .Pun:
            "🥴"
        case .Spooky:
            "👻"
        case .Christmas:
            "🎅🏻"
        }
    }
}
