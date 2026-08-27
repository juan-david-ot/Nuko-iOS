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

#Preview {
    ContentView().environmentObject(AuthEnvironment())
}
