//
//  SignUpFormView.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import SwiftUI

private enum FocusedField: Hashable {
    case email, username, name, surname, password
}

struct SignUpFormView: View {
    @Binding var selectedTab: Int
    
    @State private var email = ""
    @State private var username = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isLoading = false
    
    @FocusState private var focus: FocusedField?
    
    @State private var emailError: String?
    @State private var usernameError: String?
    @State private var passwordError: String?
    @State private var errorMessage: String?
    
    private func validate() -> Bool {
        emailError = email.isEmpty ? "Este campo es obligatorio" : nil
        usernameError = username.isEmpty ? "Este campo es obligatorio" : nil
        passwordError = password.isEmpty ? "Este campo es obligatorio" : nil
        return emailError == nil && usernameError == nil && passwordError == nil
    }
    
    func signUp() async {
        guard validate() else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await AuthService.signUp(user: User(email: email, username: username, password: password, name: name, surname: surname))
            errorMessage = nil
            selectedTab = 0
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("¡Regístrate!")
                .font(.title2.bold())
            Text("Ha-Nuko Matata. Convive y deja vivir.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    RequiredLabel(text: "Email")
                    TextField("Introduce tu email", text: $email)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .focused($focus, equals: .email)
                        .submitLabel(.go)
                        .fieldContainerStyle(hasError: emailError != nil)
                        .onChange(of: email) { _, _ in emailError = nil }
                    FieldErrorText(text: emailError)
                }
                VStack(alignment: .leading, spacing: 4) {
                    RequiredLabel(text: "Nombre de usuario")
                    TextField("Introduce tu nombre de usuario", text: $username)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focus, equals: .username)
                        .submitLabel(.go)
                        .fieldContainerStyle(hasError: usernameError != nil)
                        .onChange(of: username) { _, _ in usernameError = nil }
                    FieldErrorText(text: usernameError)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nombre")
                        .font(.footnote.bold())
                    TextField("Introduce tu nombre", text: $name)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                        .focused($focus, equals: .name)
                        .submitLabel(.go)
                        .fieldContainerStyle()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Apellido")
                        .font(.footnote.bold())
                    TextField("Introduce tu apellido", text: $surname)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                        .focused($focus, equals: .surname)
                        .submitLabel(.go)
                        .fieldContainerStyle()
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
                case .email:
                    focus = .username
                case .username:
                    focus = .name
                case .name:
                    focus = .surname
                case .surname:
                    focus = .password
                case .password:
                    focus = nil
                    Task { await signUp() }
                default:
                    print("None")
                }
            }
            
            HStack {
                Button {
                    Task { await signUp() }
                } label: {
                    if isLoading {
                        ProgressView()
                            .tint(.accent)
                    } else {
                        Label("Registrarse", systemImage: "checkmark")
                            .foregroundStyle(.black)
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
    SignUpFormView(selectedTab: .constant(1))
}
