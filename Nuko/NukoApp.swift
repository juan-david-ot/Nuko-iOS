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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authEnvironment)
                .task {
                    await authEnvironment.authUser()
                }
        }
    }
}
