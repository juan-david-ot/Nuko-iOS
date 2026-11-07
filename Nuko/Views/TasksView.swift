//
//  TasksView.swift
//  Nuko
//
//  Created by JuanDa on 07/11/2026.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(systemName: "checklist.unchecked")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Checklist!")
                }
                .padding()
            }
            .navigationTitle("Tareas")
        }
    }
}

#Preview {
    TasksView()
}
