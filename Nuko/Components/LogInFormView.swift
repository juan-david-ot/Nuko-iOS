//
//  LogInFormView.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import SwiftUI

struct LogInFormView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    
    @State private var identifier = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    func logIn() async {
        isLoading = true
        defer { isLoading = false }
        
        var isEmail: Bool {
            let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
            return identifier.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
        }
        do {
            let token = try await AuthService.logIn(user: isEmail ? User(email: identifier, password: password) : User(username: identifier, password: password))
            UserDefaults.standard.set(token, forKey: "authToken")
            await authEnvironment.authUser()
            errorMessage = nil
        }
        catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("¡Inicia sesión!")
                .font(.title2.bold())
            Text("Ha-Nuko Matata.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email/Nombre de usuario")
                        .font(.footnote.bold())
                    TextField("Introduce tu email o nombre de usuario", text: $identifier)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(.separator), lineWidth: 1))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Contraseña")
                        .font(.footnote.bold())
                    
                    HStack {
                        Group {
                            if isPasswordVisible {
                                TextField("Introduce tu contraseña", text: $password)
                            } else {
                                SecureField("Introduce tu contraseña", text: $password)
                            }
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(.plain)
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .frame(width: 20, height: 20)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 20)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .background(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(.separator), lineWidth: 1))
                    
                    HStack {
                        Spacer()
                        NavigationLink("¿Has olvidado tu contraseña?") {
                            Text("Recuperar contraseña")
                        }
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                    }
                }
                
                if let errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            }
            .padding(.top, 12)
            
            HStack {
                Button {
                    Task { await logIn() }
                } label: {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Label("Iniciar Sesión", systemImage: "checkmark").foregroundStyle(.black)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 16)
                .disabled(isLoading)
                Spacer()
            }
        }
    }
}

#Preview {
    LogInFormView()
}
