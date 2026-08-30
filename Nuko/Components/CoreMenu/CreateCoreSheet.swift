//
//  CreateCoreSheet.swift
//  Nuko
//
//  Created by JuanDa on 30/08/2026.
//

import SwiftUI

struct CreateCoreSheet: View {
    @EnvironmentObject private var coresEnvironment: CoresEnvironment
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var nameError: String?
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    private func validate() -> Bool {
        nameError = name.isEmpty ? "Este campo es obligatorio" : nil
        return nameError == nil
    }
    
    private func createCore() async {
        guard validate() else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await CoreService.createCore(core: Core(name: name))
            await coresEnvironment.refreshCores()
            coresEnvironment.core = response.newCore.id
            errorMessage = nil
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Image(systemName: "atom")
                    .font(.system(size: 22))
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
                    .background(Color.accentColor, in: Circle())
                
                Text("¡Crea un Nuevo Núcleo!")
                    .font(.headline)
            }
            .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                RequiredLabel(text: "Nombre")
                TextField("Nombre del nuevo Núcleo", text: $name)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .fieldContainerStyle(hasError: nameError != nil)
                    .onChange(of: name) { _, _ in nameError = nil }
                FieldErrorText(text: nameError)
            }
            
            if let errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(spacing: 12) {
                Button {
                    Task { await createCore() }
                } label: {
                    if isLoading {
                        ProgressView()
                            .tint(.black)
                    } else {
                        Label("Crear", systemImage: "checkmark")
                            .foregroundStyle(.black)
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .disabled(isLoading)
                
                Button("Cancelar") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                .foregroundStyle(Color.secondary)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(24)
    }
}

#Preview {
    CreateCoreSheet()
}
