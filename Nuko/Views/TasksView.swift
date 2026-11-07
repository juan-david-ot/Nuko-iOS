//
//  TasksView.swift
//  Nuko
//
//  Created by JuanDa on 07/11/2026.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject private var coresEnvironment: CoresEnvironment

    @State private var taskLists: [TaskList] = []
    @State private var isLoading = false

    private func loadTaskLists() async {
        guard let coreId = coresEnvironment.core else {
            taskLists = []
            isLoading = false
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            taskLists = try await TaskListService.getTaskListsByCoreId(coreId)
                .sorted { ($0.position ?? 0) < ($1.position ?? 0) }
        } catch {
            taskLists = []
            print(error)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Group {
                        if isLoading {
                            VStack(spacing: 10) {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.thinMaterial)
                                    .frame(height: 300)
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.thinMaterial)
                                    .frame(height: 300)
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.thinMaterial)
                                    .frame(height: 300)
                            }
                        } else if taskLists.isEmpty {
                            Text("No hay ningún núcleo activo o lista disponible")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                        } else {
                            LazyVStack(spacing: 10) {
                                ForEach(taskLists.indices, id: \.self) { index in
                                    let taskList = taskLists[index]
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text(taskList.name ?? "Lista")
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Tareas...")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 275, alignment: .topLeading)
                                    .background(.surface, in: RoundedRectangle(cornerRadius: 24))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Tareas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarTitleAlignment(.leading)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Crear Lista") {
                        
                    }
                    .fontWeight(.regular)
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.black)
                }
            }
            .task(id: coresEnvironment.core) {
                await loadTaskLists()
            }
        }
    }
}

#Preview {
    TasksView()
        .environmentObject(CoresEnvironment())
}
