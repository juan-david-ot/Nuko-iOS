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
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authEnvironment)
                .environmentObject(coresEnvironment)
                .preferredColorScheme(appTheme.colorScheme)
                .task {
                    await authEnvironment.authUser()
                }
        }
    }
}
