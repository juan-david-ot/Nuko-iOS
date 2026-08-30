//
//  HomeView.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

enum HomeTab: Int {
    case resume, core, chat
}

struct HomeView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    @EnvironmentObject private var coresEnvironment: CoresEnvironment
    
    @State private var selectedTab: HomeTab = HomeTab.resume
    @State private var core: Core?
    @State private var isLoading = false
    @State private var inviteLink: String?
    @State private var inviteError: String?
    @State private var isInviteModalOpen = false
    
    private func loadCoreInformation() async {
        guard let coreId = coresEnvironment.core else {
            core = nil
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            core = try await CoreService.getUserCoreInformationById(coreId: coreId)
        } catch {
            core = nil
            print(error)
        }
    }
    
    private func createInvitation() async {
        guard let coreId = coresEnvironment.core else { return }
        
        do {
            inviteLink = try await CoreService.createInvitationToCore(coreId: coreId)
            inviteError = nil
        } catch {
            inviteError = "No tienes ningún núcleo seleccionado o ha habido un error al crear la invitación"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        Group {
                            switch selectedTab {
                            case .resume: resumeTab
                            case .core: coreTab
                            case .chat: chatTab
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
                    header: {
                        UnderlineTab(selectedTab: $selectedTab)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
//                            .glassEffect(.clear)
                    }
                }
            }
            .navigationTitle("Home")
            .task(id: coresEnvironment.core) {
                await loadCoreInformation()
            }
            .sheet(isPresented: $isInviteModalOpen) {
                InviteLinkSheet(inviteLink: inviteLink, error: inviteError)
                    .presentationDetents([.height(220)])
            }
        }
    }
    
    @ViewBuilder
    private var resumeTab: some View {
        if isLoading {
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 24).fill(.thinMaterial).frame(height: 112)
                RoundedRectangle(cornerRadius: 24).fill(.thinMaterial).frame(height: 112)
                RoundedRectangle(cornerRadius: 24).fill(.thinMaterial).frame(height: 112)
            }
        } else if core != nil {
            VStack(spacing: 12) {
                InfoCard(icon: "calendar", title: "Próximos Eventos") {
                    Text("Cumpleaños Mamá")
                    Text("Cena con Sara").foregroundStyle(.secondary)
                    Text("Cine en Familia").foregroundStyle(.secondary)
                    Text("Veterinario").foregroundStyle(.secondary)
                }
                
                InfoCard(icon: "checklist", title: "Tareas Pendientes") {
                    Text("Comprar Fruta")
                    Text("Llamar al banco").foregroundStyle(.secondary)
                    Text("Ordenar el trastero").foregroundStyle(.secondary)
                }
                InfoCard(icon: "dollarsign", title: "Últimos Gastos") {
                    Text("Netflix: 12€")
                    Text("Helado: 10€").foregroundStyle(.secondary)
                    Text("Cena Familiar: 100€").foregroundStyle(.secondary)
                }
            }
        } else {
            Text("No hay ningún núcleo activo, selecciona o crea uno")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
        }
    }
    
    @ViewBuilder
    private var coreTab: some View {
        if isLoading {
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 24).fill(.thinMaterial).frame(height: 80)
                RoundedRectangle(cornerRadius: 24).fill(.thinMaterial).frame(height: 200)
            }
        } else if let core {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Núcleo").font(.subheadline.bold())
                    HStack {
                        Text("Nombre:")
                        Text(core.name ?? "Nucleo").foregroundStyle(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Miembros").font(.subheadline.bold())
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(core.users ?? [], id: \.id) { member in
                                HStack(spacing: 10) {
                                    AsyncImage(url: URL(string: "https://heroui-assets.nyc3.cdn.digitaloceanspaces.com/avatars/green.jpg")) { phase in
                                        if case .success(let image) = phase {
                                            image.resizable().scaledToFill()
                                        } else {
                                            Circle().fill(.thinMaterial)
                                                .overlay(Text(getCapitals(member.name ?? "?")).font(.caption.bold()))
                                        }
                                    }
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text("@\(member.username?.capitalized ?? "") - \(member.name ?? "")")
                                            .font(.subheadline)
                                        Text(member.email ?? "")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    }
                    .frame(maxHeight: 208)
                    
                    Button {
                        isInviteModalOpen = true
                        Task { await createInvitation() }
                    } label: {
                        Label("Invitar Miembro", systemImage: "plus")
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Psicología").font(.subheadline.bold())
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("¿Cómo te sientes hoy?")
                        HStack(spacing: 12) {
                            Button {} label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.bordered)
                            Button {} label: {
                                Image(systemName: "slash.circle.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.bordered)
                            Button {} label: {
                                Image(systemName: "xmark.circle.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding()
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Reflexión del día")
                        Text("Comunicar antes que asumir").foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                }
            }
        } else {
            Text("No hay ningún núcleo activo, selecciona o crea uno")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
        }
    }
    
    @ViewBuilder
    private var chatTab: some View {
        if core != nil {
            Text("Aquí va a ir el chat")
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
        } else {
            Text("No hay ningún núcleo activo, selecciona o crea uno")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthEnvironment())
        .environmentObject(CoresEnvironment())
}
