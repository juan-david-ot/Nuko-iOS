//
//  LogInFormView.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import SwiftUI

private enum FocusedField: Hashable {
    case identifier, password
}

struct LogInFormView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    
    @State private var identifier = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isLoading = false

    @FocusState private var focus: FocusedField?
    
    @State private var identifierError: String?
    @State private var passwordError: String?
    @State private var errorMessage: String?
    
    private func validate() -> Bool {
        identifierError = identifier.isEmpty ? "Este campo es obligatorio" : nil
        passwordError = password.isEmpty ? "Este campo es obligatorio" : nil
        return identifierError == nil && passwordError == nil
    }
    
    func logIn() async {
        guard validate() else { return }
        
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
            errorMessage = error.localizedDescription
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
                    RequiredLabel(text: "Email/Nombre de usuario")
                    TextField("Introduce tu email o nombre de usuario", text: $identifier)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focus, equals: .identifier)
                        .submitLabel(.go)
                        .fieldContainerStyle(hasError: identifierError != nil)
                        .onChange(of: identifier) { _, _ in identifierError = nil }
                    FieldErrorText(text: identifierError)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    RequiredLabel(text: "Contraseña")
                    
                    HStack {
                        Group {
                            if isPasswordVisible {
                                TextField("Introduce tu contraseña", text: $password)
                                    .focused($focus, equals: .password)
                                    .submitLabel(.done)
                            } else {
                                SecureField("Introduce tu contraseña", text: $password)
                                    .focused($focus, equals: .password)
                                    .submitLabel(.done)
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
                    .fieldContainerStyle(hasError: passwordError != nil)
                    .onChange(of: password) { _, _ in passwordError = nil }
                    FieldErrorText(text: passwordError)
                    
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
            .onSubmit {
                switch focus {
                case .identifier:
                    focus = .password
                case .password:
                    focus = nil
                    Task { await logIn() }
                default:
                    print("None")
                }
            }
            
            HStack {
                Button {
                    Task { await logIn() }
                } label: {
                    if isLoading {
                        ProgressView()
                            .tint(.accent)
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
