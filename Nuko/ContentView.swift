//
//  ContentView.swift
//  Nuko
//
//  Created by JuanDa on 25/3/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
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
            Tab("Calendario", systemImage: "calendar") {
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
            Tab("Finanzas", systemImage: "dollarsign") {
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
            Tab ("Tareas", systemImage: "checklist.unchecked") {
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
            Tab("Ajustes", systemImage: "gearshape.fill") {
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
    }
}

#Preview {
    ContentView()
}
