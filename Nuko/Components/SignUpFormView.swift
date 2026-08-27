//
//  SignUpFormView.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import SwiftUI

struct SignUpFormView: View {
    //    @EnvironmentObject private var authEnvironment: AuthEnvironment
    
    @State private var email = ""
    @State private var username = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("¡Regístrate!")
                .font(.title2.bold())
            Text("Ha-Nuko Matata. Convive y deja vivir.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email")
                        .font(.footnote.bold())
                    TextField("Introduce tu email", text: $email)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(.separator), lineWidth: 1))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nombre de usuario")
                        .font(.footnote.bold())
                    TextField("Introduce tu nombre de usuario", text: $username)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(.separator), lineWidth: 1))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nombre")
                        .font(.footnote.bold())
                    TextField("Introduce tu nombre", text: $name)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemBackground))
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder(Color(.separator), lineWidth: 1))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Apellido")
                        .font(.footnote.bold())
                    TextField("Introduce tu apellido", text: $surname)
                        .textFieldStyle(.plain)
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
                }
                
                if let errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            }
            .padding(.top, 12)
            
            HStack{
                Button {
                    print("signup")
                } label: {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
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
    SignUpFormView()
}
