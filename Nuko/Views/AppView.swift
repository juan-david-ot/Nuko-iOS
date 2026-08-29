//
//  AppView.swift
//  Nuko
//
//  Created by JuanDa on 19/08/2026.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            Tab("", systemImage: "house.fill") {
                NavigationStack {
                    VStack {
                        Image(systemName: "house.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, Home!")
                    }
                    .padding()
                }
            }
            Tab("", systemImage: "calendar") {
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
            Tab("", systemImage: "dollarsign") {
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
            Tab ("", systemImage: "checklist.unchecked") {
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
            Tab("", systemImage: "gearshape.fill") {
                NavigationStack {
                    VStack {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, Gearshape!")
                    }
                    .padding()
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .overlay(alignment: .bottomTrailing) {
            CoreMenuButton()
                .padding(.trailing, 16)
                .padding(.bottom, 90)
        }
    }
}

#Preview {
    AppView()
        .environmentObject(AuthEnvironment())
        .environmentObject(CoresEnvironment())
}
