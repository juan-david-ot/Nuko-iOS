//
//  CoreMenuButton.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import SwiftUI

struct CoreMenuButton: View {
    // Placeholder — cuando montemos el CoreEnvironment, esto vendrá de ahí
    let cores: [String] = []
    @State private var selectedCore: String? = nil

    var body: some View {
        Menu {
            if cores.isEmpty {
                Text("Aún no tienes ningún núcleo...")
            } else {
                Picker("Escoge un Núcleo", selection: $selectedCore) {
                    ForEach(cores, id: \.self) { core in
                        Text(core).tag(Optional(core))
                    }
                }
            }
            Divider()
            Button {
                // abrir modal de creación de núcleo
            } label: {
                Label("Crear núcleo", systemImage: "plus.circle")
            }
        } label: {
            Image(systemName: "atom")
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(.foreground)
                .frame(width: 52, height: 52)
                .background(.thinMaterial, in: Circle())
                .overlay(
                    Circle().stroke(.white.opacity(0.15), lineWidth: 1)
                )
        }
        .menuStyle(.borderlessButton)
    }
}

#Preview {
    CoreMenuButton()
}
