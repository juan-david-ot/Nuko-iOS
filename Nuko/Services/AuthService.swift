//
//  AuthService.swift
//  Nuko
//
//  Created by JuanDa on 26/08/2026.
//

import Foundation
import Alamofire

private nonisolated struct ForgotPasswordBody: Encodable, Sendable {
    let email: String
}

private nonisolated struct ResetPasswordBody: Encodable, Sendable {
    let token: String
    let newPassword: String
    let confirmNewPassword: String
}

private nonisolated struct ChangePasswordBody: Encodable, Sendable {
    let password: String
    let newPassword: String
    let confirmNewPassword: String
}

private nonisolated struct AuthTokenResponse: Decodable, Sendable {
    let authToken: String
}

private nonisolated struct VerifyResponse: Decodable, Sendable {
    let authUser: User
}

enum AuthService {
    static func signUp(user: User) async throws -> User {
        let request = AF.shared
            .request("\(AF.baseURL)/auth/signUp", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
        
        return try await decode(User.self, from: request)
    }
    
    static func logIn(user: User) async throws -> String {
        let request = AF.shared
            .request("\(AF.baseURL)/auth/logIn", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
        
        return try await decode(AuthTokenResponse.self, from: request).authToken
    }
    
    static func forgotPassword(email: String) async throws -> Void {
        let request = AF.shared
            .request("\(AF.baseURL)/auth/forgotPassword", method: .post, parameters: ForgotPasswordBody(email: email), encoder: JSONParameterEncoder.default)
            .validate()
        
        _ = try await decode(MessageResponse.self, from: request)
    }
    
    static func resetPassword(token: String, newPassword: String, confirmNewPassword: String) async throws -> User {
        let request = AF.shared
            .request("\(AF.baseURL)/auth/resetPassword", method: .post, parameters: ResetPasswordBody(token: token, newPassword: newPassword, confirmNewPassword: confirmNewPassword), encoder: JSONParameterEncoder.default)
            .validate()
        
        return try await decode(User.self, from: request)
    }
    
    static func changePassword(password: String, newPassword: String, confirmNewPassword: String) async throws -> String {
        let request = AF.shared
            .request("\(AF.baseURL)/auth/changePassword", method: .post, parameters: ChangePasswordBody(password: password, newPassword: newPassword, confirmNewPassword: confirmNewPassword), encoder: JSONParameterEncoder.default)
            .validate()
        
        return try await decode(String.self, from: request)
    }
    
    static func verify() async throws -> User {
        let request = AF.shared
            .request("\(AF.baseURL)/auth/verify")
            .validate()
        return try await decode(User.self, from: request)
    }
}
