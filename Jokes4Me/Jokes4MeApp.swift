//
//
// Jokes4Me
// Jokes4MeApp.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import SwiftUI
import LaunchAtLogin

@main
struct Jokes4MeApp: App {
    var body: some Scene {
        MenuBarExtra("Jokes4Me", image: "MenuBarIcon") {
            VStack(alignment: .leading) {
                JokeContentView()
                
                Divider()
                
                HStack {
                    LaunchAtLogin.Toggle()
                    Spacer()
                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    }.keyboardShortcut("q")
                }
            }
            .padding()
                .frame(width: 400, height: 400)
        }
        .menuBarExtraStyle(.window)
    }
}
