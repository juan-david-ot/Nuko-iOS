//
//  ForgotPassword.swift
//  Nuko
//
//  Created by JuanDa on 30/08/2026.
//

import SwiftUI

struct ForgotPassword: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var emailError: String?
    @State private var isLoading = false
    
    private func validate() -> Bool {
        emailError = email.isEmpty ? "Este campo es obligatorio" : nil
        return emailError == nil
    }
    
    private func forgotPassword() async {
        guard validate() else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AuthService.forgotPassword(email: email)
        } catch {
            print(error)
        }
        
        dismiss()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text("Recupera tu cuenta")
                    .font(.title2.bold())
                Text("Te enviaremos un correo para que restablezcas tu contraseña")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                VStack(alignment: .leading, spacing: 4) {
                    RequiredLabel(text: "Email")
                    TextField("Introduce tu email", text: $email)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .fieldContainerStyle(hasError: emailError != nil)
                        .onChange(of: email) { _, _ in emailError = nil }
                    FieldErrorText(text: emailError)
                }
                .padding(.top, 16)
                
                HStack {
                    Button {
                        Task { await forgotPassword() }
                    } label: {
                        if isLoading {
                            ProgressView()
                                .tint(.black)
                        } else {
                            Label("Continuar", systemImage: "checkmark")
                                .foregroundStyle(.black)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isLoading)
                    Spacer()
                }
                .padding(.top, 16)
            }
            .padding(20)
            .background(.cards, in: RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    ForgotPassword()
}
