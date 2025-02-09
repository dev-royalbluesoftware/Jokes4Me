//
//
// Jokes4MeiOS
// ChartItem.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import Foundation

struct ChartItem: Identifiable {
    
    enum JokeType: String {
        case safe, unsafe
    }
    
    let id = UUID()
    let lang: String
    let qty: Int
    let jokeType: JokeType
}
