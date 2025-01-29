//
//
// Jokes4Me
// Language.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 

import Foundation

enum Language: String, Codable, CaseIterable, Identifiable {
    case en
    case fr
    case cs
    case de
    case es
    case pt
    var id: Self { self }
    
    var full: String {
        switch self {
        case .en: "English"
        case .fr: "French"
        case .cs: "Czech"
        case .de: "German"
        case .es: "Spanish"
        case .pt: "Portuguese"
        }
    }
}
