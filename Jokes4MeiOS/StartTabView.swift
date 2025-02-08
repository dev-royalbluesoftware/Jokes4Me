//
//
// Jokes4MeiOS
// StartTabView.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import SwiftUI

struct StartTabView: View {
    var body: some View {
        TabView {
            Tab("Jokes", systemImage: "face.smiling") {
                JokeContentView()
            }
            
            Tab("Info", systemImage: "info.circle") {
                InfoView()
            }
        }
    }
}

#Preview {
    StartTabView()
}
