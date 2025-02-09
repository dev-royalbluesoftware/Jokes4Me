//
//
// Jokes4MeiOS
// FirstOnAppearModifier.swift
//
// Created by rbs-dev
// Copyright © Royal Blue Software
// 


import SwiftUI

struct FirstOnAppearModifier: ViewModifier {
    
    // MARK: - @State Properties
    
    @State private var hasPerformedAction = false
    
    // MARK: - Properties
    
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !hasPerformedAction {
                    hasPerformedAction = true
                    action?()
                }
            }
    }
}

// MARK: - Extension View

extension View {
    public func firstOnAppear(performOnce action: (() -> Void)? = nil) -> some View {
        modifier(FirstOnAppearModifier(action: action))
    }
}
