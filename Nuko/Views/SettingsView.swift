//
//  SettingsView.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

enum SettingsSection {
    case user, password
}

private enum FocusedPasswordField: Hashable {
    case password, newPassword, confirmNewPassword
}

struct SettingsView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    @State private var password = ""
    @State private var newPassword = ""
    @State private var confirmNewPassword = ""
    @State private var isPasswordVisible = false
    @State private var isNewPasswordVisible = false
    @State private var isConfirmNewPasswordVisible = false
    @State private var isLoading = false
    
    @FocusState private var passwordFocus: FocusedPasswordField?
    
    @State private var passwordError: String?
    @State private var newPasswordError: String?
    @State private var confirmNewpasswordError: String?
    @State private var errorMessage: String?
    
    @State private var expandedSection: SettingsSection? = nil
    
    private var capitals: String {
        let name = authEnvironment.user?.name ?? authEnvironment.user?.username ?? "?"
        return getCapitals(name)
    }
    
    private func validate() -> Bool {
        passwordError = password.isEmpty ? "Este campo es obligatorio" : nil
        newPasswordError = newPassword.isEmpty ? "Este campo es obligatorio" : nil
        confirmNewpasswordError = confirmNewPassword.isEmpty ? "Este campo es obligatorio" : nil
        return passwordError == nil && newPasswordError == nil && confirmNewpasswordError == nil
    }
    
    private func changePassword() async {
        guard validate() else { return }
        
        guard password != newPassword else {
            errorMessage = "Tu nueva contraseña no puede ser la misma que la anterior"
            return
        }
        guard newPassword == confirmNewPassword else {
            errorMessage = "La nueva contraseña no está confirmada"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let token = try await AuthService.changePassword(
                password: password,
                newPassword: newPassword,
                confirmNewPassword: confirmNewPassword
            )
            print(token)
            UserDefaults.standard.set(token, forKey: "authToken")
            expandedSection = nil
            password = ""
            newPassword = ""
            confirmNewPassword = ""
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    DisclosureGroup(isExpanded: Binding(
                        get: { expandedSection == .user },
                        set: { expandedSection = $0 ? .user : nil }
                    )) {
                        Text("Aquí va la configuración del usuario, como cambiar el nombre, el correo, etc.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                    } label: {
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: "https://heroui-assets.nyc3.cdn.digitaloceanspaces.com/avatars/green.jpg")) { phase in
                                if case .success(let image) = phase {
                                    image.resizable().scaledToFill()
                                } else {
                                    Circle().fill(.thinMaterial)
                                        .overlay(Text(getCapitals(authEnvironment.user?.name ?? "N")).font(.caption.bold()))
                                }
                            }
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("@\(authEnvironment.user?.username ?? "") - \(authEnvironment.user?.name ?? "")")
                                    .font(.subheadline.bold())
                                Text(authEnvironment.user?.email ?? "")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding()
                    .foregroundStyle(Color(.label))
                    
                    Divider()
                    
                    DisclosureGroup("Cambiar Contraseña", isExpanded: Binding(
                        get: { expandedSection == .password },
                        set: { expandedSection = $0 ? .password : nil }
                    )) {
                        VStack(spacing: 12) {
                            RequiredLabel(text: "Contraseña")
                            HStack {
                                Group {
                                    if isPasswordVisible {
                                        TextField("Introduce tu contraseña actual", text: $password)
                                            .focused($passwordFocus, equals: .password)
                                            .submitLabel(.go)
                                    } else {
                                        SecureField("Introduce tu contraseña actual", text: $password)
                                            .focused($passwordFocus, equals: .password)
                                            .submitLabel(.go)
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
//                            SecureField("Introduce tu contraseña actual", text: $password)
//                                .fieldContainerStyle()
                            
                            RequiredLabel(text: "Nueva Contraseña")
                            HStack {
                                Group {
                                    if isNewPasswordVisible {
                                        TextField("Introduce tu nueva contraseña", text: $newPassword)
                                            .focused($passwordFocus, equals: .newPassword)
                                            .submitLabel(.go)
                                    } else {
                                        SecureField("Introduce tu nueva contraseña", text: $newPassword)
                                            .focused($passwordFocus, equals: .newPassword)
                                            .submitLabel(.go)
                                    }
                                }
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .textFieldStyle(.plain)
                                
                                Button {
                                    isNewPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isNewPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(height: 20)
                            .fieldContainerStyle(hasError: newPasswordError != nil)
                            .onChange(of: newPassword) { _, _ in newPasswordError = nil }
                            FieldErrorText(text: newPasswordError)
//                            SecureField("Introduce tu nueva contraseña", text: $newPassword)
//                                .fieldContainerStyle()
                            
                            RequiredLabel(text: "Confirmar Contraseña")
                            HStack {
                                Group {
                                    if isConfirmNewPasswordVisible {
                                        TextField("Confirma tu nueva contraseña", text: $confirmNewPassword)
                                            .focused($passwordFocus, equals: .confirmNewPassword)
                                            .submitLabel(.done)
                                    } else {
                                        SecureField("Confirma tu nueva contraseña", text: $confirmNewPassword)
                                            .focused($passwordFocus, equals: .confirmNewPassword)
                                            .submitLabel(.done)
                                    }
                                }
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .textFieldStyle(.plain)
                                
                                Button {
                                    isConfirmNewPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isConfirmNewPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(height: 20)
                            .fieldContainerStyle(hasError: confirmNewpasswordError != nil)
                            .onChange(of: confirmNewPassword) { _, _ in confirmNewpasswordError = nil }
                            FieldErrorText(text: confirmNewpasswordError)
//                            SecureField("Confirma tu nueva contraseña", text: $confirmNewPassword)
//                                .fieldContainerStyle()
                            
                            if let errorMessage {
                                Text(errorMessage)
                                    .font(.footnote)
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    Task { await changePassword() }
                                } label: {
                                    if isLoading {
                                        ProgressView()
                                    } else {
                                        Label("Cambiar Contraseña", systemImage: "checkmark").foregroundStyle(.black)
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(isLoading)
                            }
                        }
                        .padding(.top, 12)
                        .onSubmit {
                            switch passwordFocus {
                            case .password:
                                passwordFocus = .newPassword
                            case .newPassword:
                                passwordFocus = .confirmNewPassword
                            case .confirmNewPassword:
                                passwordFocus = nil
                                Task { await changePassword() }
                            default:
                                print("None")
                            }
                        }
                    }
                    .padding()
                    .foregroundStyle(Color(.label))
                    
                    Divider()
                    
                    HStack {
                        Text("Tema")
                        Spacer()
                        Picker("Tema", selection: $appTheme) {
                            ForEach(AppTheme.allCases) { theme in
                                Text(theme.label).tag(theme)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color(.label))
                    }
                    .padding()
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        Task {
                            await authEnvironment.logOut()
                        }
                    } label: {
                        Text("Cerrar sesión")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                .padding()
            }
            .navigationTitle("Ajustes")
            .scrollDismissesKeyboard(.interactively)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(AuthEnvironment())
}
