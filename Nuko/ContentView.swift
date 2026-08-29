//
//  ContentView.swift
//  Nuko
//
//  Created by JuanDa on 25/3/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    
    var body: some View {
        if authEnvironment.isLoading {
            ProgressView()
                .tint(.accent)
                .scaleEffect(2)
        }
        else {
            if authEnvironment.user != nil {
                AppView()
            }
            if authEnvironment.user == nil {
                AuthView()
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthEnvironment())
        .environmentObject(CoresEnvironment())
}
