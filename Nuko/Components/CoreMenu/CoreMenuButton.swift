//
//  CoreMenuButton.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import SwiftUI

struct CoreMenuButton: View {
    @EnvironmentObject private var coresEnvironment: CoresEnvironment
    @State private var isOpen = false
    @State private var isModalOpen: Bool = false
    
    var body: some View {
        Button {
            isOpen.toggle()
        }
        label: {
            Image(systemName: "atom")
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(.foreground)
                .frame(width: 52, height: 52)
                .contentShape(Circle())
//                .background(.thinMaterial, in: Circle())
//                .overlay(
//                    Circle().stroke(.white.opacity(0.15), lineWidth: 1)
//                )
        }
        .frame(width: 52, height: 52)
        .buttonStyle(.plain)
        .glassEffect(.clear.interactive(), in: .circle)
        .popover(isPresented: $isOpen, arrowEdge: .bottom) {
            CoreMenuPopover(isOpen: $isOpen, isModalOpen: $isModalOpen)
                .presentationCompactAdaptation(.popover)
                .presentationBackground(.clear)
        }
        .task {
            await coresEnvironment.refreshCores()
        }
        .sheet(isPresented: $isModalOpen) {
            CreateCoreSheet()
                .presentationDetents([.fraction(0.5)])
        }
//        Menu {
//            if coresEnvironment.cores.isEmpty {
//                Text("Aún no tienes ningún núcleo...")
//            } else {
//                Picker("Escoge un Núcleo", selection: $coresEnvironment.core) {
//                    ForEach(coresEnvironment.cores) { core in
//                        Text(core.name ?? "Núcleo").tag(Optional(core.id))
//                    }
//                }
//            }
//            Divider()
//            Button {
//                isModalOpen = true
//            } label: {
//                Label("Crear núcleo", systemImage: "plus.circle")
//            }
//        } label: {
//            Image(systemName: "atom")
//                .font(.system(size: 22, weight: .regular))
//                .foregroundStyle(.foreground)
//                .frame(width: 52, height: 52)
//                .background(.thinMaterial, in: Circle())
//                .overlay(
//                    Circle().stroke(.white.opacity(0.15), lineWidth: 1)
//                )
//        }
//        .menuStyle(.borderlessButton)
//        .task {
//            await coresEnvironment.refreshCores()
//        }
//        .sheet(isPresented: $isModalOpen) {
//            Text("Modal de crear núcleo")
//                .presentationDetents([.medium])
//        }
    }
}

#Preview {
    CoreMenuButton().environmentObject(CoresEnvironment())
}
