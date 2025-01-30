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
                Text("Joke View")
            }
            
            Tab("Info", systemImage: "info.circle") {
                Text("Joke Distribution View")
            }
        }
    }
}

#Preview {
    StartTabView()
}
