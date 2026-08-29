//
//  NukoApp.swift
//  Nuko
//
//  Created by JuanDa on 25/3/26.
//

import SwiftUI

@main
struct NukoApp: App {
    @StateObject private var authEnvironment = AuthEnvironment()
    @StateObject private var coresEnvironment = CoresEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(authEnvironment)
                .environmentObject(coresEnvironment)
                .task {
                    await authEnvironment.authUser()
                }
        }
    }
}
