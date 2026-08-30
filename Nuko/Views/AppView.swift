//
//  AppView.swift
//  Nuko
//
//  Created by JuanDa on 19/08/2026.
//

import SwiftUI

private enum AppTab: Hashable {
    case home, calendar, finances, tasks, settings
}

struct AppView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("", systemImage: "house.fill", value: AppTab.home) {
                HomeView()
            }
            Tab("", systemImage: "calendar", value: AppTab.calendar) {
                NavigationStack {
                    VStack {
                        Image(systemName: "calendar")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, Calendar!")
                    }
                    .padding()
                }
            }
            Tab("", systemImage: "dollarsign", value: AppTab.finances) {
                NavigationStack {
                    VStack {
                        Image(systemName: "dollarsign")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, Finances!")
                    }
                    .padding()
                }
            }
            Tab ("", systemImage: "checklist.unchecked", value: AppTab.tasks) {
                NavigationStack {
                    VStack {
                        Image(systemName: "checklist.unchecked")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, Checklist!")
                    }
                    .padding()
                }
            }
            Tab("", systemImage: "gearshape.fill", value: AppTab.settings) {
                SettingsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .toolbarBackground(.hidden, for: .tabBar)
        .overlay(alignment: .bottomTrailing) {
            CoreMenuButton()
                .padding(.trailing, 16)
                .padding(.bottom, 70)
        }
        .onChange(of: selectedTab) { _, _ in
            Task {
                await authEnvironment.authUser()
            }
        }
    }
}

#Preview {
    AppView()
        .environmentObject(AuthEnvironment())
        .environmentObject(CoresEnvironment())
}
