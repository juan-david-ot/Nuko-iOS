//
//  ContentView.swift
//  Nuko
//
//  Created by JuanDa on 25/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                VStack {
                    Image(systemName: "house.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Home!")
                }
                .padding()
            }
            Tab("Calendario", systemImage: "calendar") {
                VStack {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Calendar!")
                }
                .padding()
            }
            Tab("Finanzas", systemImage: "dollarsign") {
                VStack {
                    Image(systemName: "dollarsign")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Finances!")
                }
                .padding()
            }
            Tab ("Tareas", systemImage: "checklist.unchecked") {
                VStack {
                    Image(systemName: "checklist.unchecked")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Checklist!")
                }
                .padding()
            }
            Tab("Ajustes", systemImage: "gearshape.fill") {
                VStack {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Gearshape!")
                }
                .padding()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .background(Color(.accent))
    }
}

#Preview {
    ContentView()
}
