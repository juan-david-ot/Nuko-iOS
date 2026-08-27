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
        let response = try await AF.shared
            .request("\(AF.baseURL)/auth/signUp", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .serializingDecodable(User.self, decoder: JSONDecoder.nukoDecoder)
            .value
        print(response)
        return response
    }
    
    static func logIn(user: User) async throws -> String {
        try await AF.shared
            .request("\(AF.baseURL)/auth/logIn", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate()
            .serializingDecodable(AuthTokenResponse.self, decoder: JSONDecoder.nukoDecoder)
            .value
            .authToken
    }
    
    static func forgotPassword(email: String) async throws -> Void {
        _ = try await AF.shared
            .request("\(AF.baseURL)/auth/forgotPassword", method: .post, parameters: ForgotPasswordBody(email: email), encoder: JSONParameterEncoder.default)
            .validate()
            .serializingDecodable(MessageResponse.self, emptyResponseCodes: [200, 204])
            .value
    }
    
    static func resetPassword(token: String, newPassword: String, confirmNewPassword: String) async throws -> User {
        try await AF.shared
            .request("\(AF.baseURL)/auth/resetPassword", method: .post, parameters: ResetPasswordBody(token: token, newPassword: newPassword, confirmNewPassword: confirmNewPassword), encoder: JSONParameterEncoder.default)
            .validate()
            .serializingDecodable(User.self, emptyResponseCodes: [200, 204])
            .value
    }
    
    static func changePassword(password: String, newPassword: String, confirmNewPassword: String) async throws -> String {
        try await AF.shared
            .request("\(AF.baseURL)/auth/changePassword", method: .post, parameters: ChangePasswordBody(password: password, newPassword: newPassword, confirmNewPassword: confirmNewPassword), encoder: JSONParameterEncoder.default)
            .validate()
            .serializingDecodable(AuthTokenResponse.self, emptyResponseCodes: [200, 204])
            .value
            .authToken
    }
    
    static func verify() async throws -> User {
        try await AF.shared
            .request("\(AF.baseURL)/auth/verify")
            .validate()
            .serializingDecodable(VerifyResponse.self, decoder: JSONDecoder.nukoDecoder)
            .value
            .authUser
    }
}
