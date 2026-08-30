//
//  CoreMenuPopover.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

struct CoreMenuPopover: View {
    @EnvironmentObject private var coresEnvironment: CoresEnvironment
    @Binding var isOpen: Bool
    @Binding var isModalOpen: Bool
    
//    private let maxListHeight: CGFloat = UIScreen.main.bounds.height * 0.3
    private let rowHeight: CGFloat = 44
    
    private var idealListHeight: CGFloat {
        CGFloat(coresEnvironment.cores.count) * rowHeight
    }

    var body: some View {
        let maxListHeight = screenHeight * 0.3
        GlassEffectContainer {
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    isOpen = false
                    isModalOpen = true
                } label: {
                    Label("Crear núcleo", systemImage: "plus.circle")
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
                
                Divider()
                    .padding(.horizontal, 10)
                
                // Tarjeta con la lista de cores
                VStack(alignment: .leading, spacing: 4) {
                    Text("Escoge un Núcleo")
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.top, 10)
                    
                    if coresEnvironment.cores.isEmpty {
                        Text("Aún no tienes ningún núcleo...")
                            .font(.footnote)
                            .padding(12)
                    } else {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(coresEnvironment.cores) { core in
                                    Button {
                                        coresEnvironment.core = coresEnvironment.core == core.id ? nil : core.id
                                        isOpen = false
                                    } label: {
                                        HStack {
                                            Text(core.name ?? "Núcleo")
                                            Spacer()
                                            if coresEnvironment.core == core.id {
                                                Image(systemName: "checkmark.circle.fill")
                                            }
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 10)
                                        .contentShape(Rectangle())
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .frame(height: min(idealListHeight, maxListHeight))
                        .padding(.bottom, 8)
                    }
                }
            }
            .padding(10)
            .frame(width: 240)
        }
    }
}

private extension View {
    var screenHeight: CGFloat {
        let scene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
        return scene?.screen.bounds.height ?? 800
    }
}

#Preview {
    CoreMenuPopover(isOpen: .constant(true), isModalOpen: .constant(true)).environmentObject(CoresEnvironment())
}
